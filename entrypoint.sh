#!/bin/sh
set -e

HTDOCS=/srv/htdocs

if [ "$1" = 'devd' ]; then
    if [ -z ${GIT_CLONE_URL+x} ]; then 
        echo "No git repository URL to clone specified, can't serve content"
	echo "Please provide GIT_CLONE_URL environment variable"
	exit
    fi

    git clone $GIT_CLONE_URL $HTDOCS
    cp /srv/index.html $HTDOCS
fi

echo "$@"

exec "$@"
