#!/bin/sh
set -e


if [ "$1" = '/usr/bin/supervisord' ]; then
    if [ -z ${GIT_CLONE_URL+x} ]; then 
        echo "No git repository URL to clone specified, can't serve content"
        echo "Please provide GIT_CLONE_URL environment variable"
        exit
    fi

    rm -rf "${FS_SRV}/htdocs"
    git clone $GIT_CLONE_URL "${FS_SRV}/htdocs"
    cp "${FS_SRV}/index.html" "${FS_SRV}/htdocs"
fi

envsubst < "${FS_OPT}/hooks.json.tpl" > "${FS_OPT}/hooks.json"

exec "$@"
