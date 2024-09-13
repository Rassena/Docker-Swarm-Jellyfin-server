#!/bin/sh -eu

set -a
. ./.env

mkdir -p $TDARR_SERVER $TDARR $TDARR_CONFIG $TDARR_CACHE $TDARR_LOGS
docker stack deploy -c ./docker-compose_tdarr.yml tdarr
