#!/bin/sh
set -e

cd "${FS_SRV}/htdocs"
sudo -u "${USER}" git pull
