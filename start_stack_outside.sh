#!/bin/sh -eu

set -a
. ./.env

mkdir -p $LOCAL_SONARR $LOCAL_RADARR
mkdir -p $JELLYFIN_CONFIG $JELLYFIN_CACHE_DATA $JELLYFIN_BACKUP 
mkdir -p $JELLYSEERR_CONFIG $JELLYSEERR_CACHE_DATA $JELLYSEERR_BACKUP
mkdir -p $PIHOLE_ETC $PIHOLE_DNSMASQ

docker stack deploy -c ./docker-compose_outside.yml outside
