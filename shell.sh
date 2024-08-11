#!/bin/sh
#trap "" HUP INT
EXTERNAL_IP="`curl -s ifconfig.me`"
RANDOM_PORT=$((1024 + (RANDOM % 64512)))
satori run satori://shell.yml --data="{\"IP\":\"$EXTERNAL_IP\", \"PORT\":\"$RANDOM_PORT\"}"
nc -vl $RANDOM_PORT
