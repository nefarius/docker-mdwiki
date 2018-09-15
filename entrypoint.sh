#!/bin/sh
set -e

# check if run with default arguments
if [ "$1" = '/usr/bin/supervisord' ]; then
  if [ -z ${GIT_CLONE_URL+x} ]; then
    # display error on missing variable & exit
    echo "No git repository URL to clone specified, can't serve content"
    echo "Please provide GIT_CLONE_URL environment variable"
    exit
  fi

  # clean working directory
  rm -rf "${FS_SRV}/htdocs"
  # clone provided repository
  git clone $GIT_CLONE_URL "${FS_SRV}/htdocs"
  # patch MDwiki into serving folder
  cp "${FS_SRV}/index.html" "${FS_SRV}/htdocs"
  # patch webhook properties template
  envsubst < "${FS_OPT}/hooks.json.tpl" > "${FS_OPT}/hooks.json"
fi

# run default command (supervisord)
exec "$@"
