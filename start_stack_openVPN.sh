#!/bin/sh -eu

docker network rm openVPN
# docker network create --opt=encrypted --driver=overlay --scope=swarm --attachable openVPN
docker network create --opt=encrypted --driver=bridge --scope=swarm --attachable openVPN
mkdir -p ./openVPN_arm64 ./openVPN_amd64

docker stack deploy -c ./docker-compose_openVPN.yml openVPN
