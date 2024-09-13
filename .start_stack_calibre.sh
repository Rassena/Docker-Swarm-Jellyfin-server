#!/bin/sh -eu

set -a
. ./.env

mkdir -p $CALIBRE_CONFIG $CALIBRE_WEB_CONFIG $CALIBRE_LIBRARY
docker stack deploy -c ./docker-compose_calibre.yml calibre
