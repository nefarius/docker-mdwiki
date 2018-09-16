#!/bin/sh
set -e

# check if run with default arguments
if [ "$1" = 'supervisord' ]; then
  if [ -z ${GIT_CLONE_URL+x} ]; then
    # display error on missing variable & exit
    echo "No git repository URL to clone specified, can't serve content"
    echo "Please provide GIT_CLONE_URL environment variable"
    exit
  fi
  
  # create non-root user
  id -u "${USER}" &>/dev/null || adduser -S "${USER}"
  # adapt permissions
  chown "${USER}" -R "${FS_SRV}"

  # clean working directory
  rm -rf "${FS_SRV}/htdocs"
  # clone provided repository
  sudo -u "${USER}" git clone $GIT_CLONE_URL "${FS_SRV}/htdocs"
  # patch MDwiki into serving folder
  cp "${FS_SRV}/index.html" "${FS_SRV}/htdocs"
  # patch webhook properties template
  envsubst < "${FS_OPT}/hooks.json.tpl" > "${FS_OPT}/hooks.json"
fi

# run default command (supervisord)
exec "$@"
