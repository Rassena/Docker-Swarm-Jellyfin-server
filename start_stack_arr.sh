#!/bin/sh -eu

set -a
. ./.env

mkdir -p $LOCAL_SONARR $SONARR_CONFIG $SONARR_BACKUP $SONARR_RECYCLEBIN
mkdir -p $LOCAL_RADARR $RADARR_CONFIG $RADARR_BACKUP $RADARR_RECYCLEBIN
mkdir -p $LOCAL_READERR $READARR_CONFIG $READARR_BACKUP $READARR_RECYCLEBIN

mkdir -p $QBITTORRENT_CONFIG $QBITTORRENT_DOWNLOADS $QBITTORRENT_IMPORTED $QBITTORRENT_BACKUP 
mkdir -p $JACKETT_CONFIG $JACKETT_BACKUP

docker stack deploy -c ./docker-compose_arr.yml arr

sleep 20

if [ $(grep -c "Password_PBKDF2" ${QBITTORRENT_CONFIG}/config/qBittorrent.conf) -lt 1 ]
then
    docker service scale arr_qbittorrent=0
    sleep 60
    tac "${QBITTORRENT_CONFIG}/config/qBittorrent.conf" | awk -v var="$QBITTORRENT_OPTION" '!f && /WebUI/{print; print var; f=1; next} 1' | tac > temp && mv temp "${QBITTORRENT_CONFIG}/config/qBittorrent.conf"
    docker service scale arr_qbittorrent=1
fi