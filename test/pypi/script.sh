#!/bin/bash

# General settings
MAX_CONT=10

# Global variables
PROJECTS=""
CONT=1

# Get the project names
while [ $CONT -le $MAX_CONT ]; do 
  PROJECTS="$PROJECTS
`curl -s "https://pypi.org/search/?c=Development+Status+%3A%3A+5+-+Production%2FStable&page=$CONT"|grep "package-snippet__name"|awk -F'>' '{print $2}'|awk -F'<' '{print $1}'`"
  CONT=$((CONT+1))
done

# Get the project repos
CONT=0
while read PROJECT; do
	REPO=`curl -s "https://pypi.org/project/$PROJECT/"|grep "file__card" -A2 -m1|grep "a href"|awk -F'"' '{print $2}'|grep "tar.gz"`
    echo "repo: curl -s https://pypi.org/project/$PROJECT/"
	if [ "$REPO" != "" ]; then
        echo "$CONT) project: $PROJECT - repo: $REPO"
    echo "settings:
  name: $REPO

install:
  - [ wget -q $REPO ; tar -zxf $(basename "$REPO") >>/dev/null ]

sensitive-keywords:
  assertStdoutEqual: ''
  keyword:
  - http://
  - https://
  - eval(
  - exec(
  - system(
  - password
  - passwd
  - username
  - credit
  - token
  execute:
  - [ grep $(keyword) * -rI ]

import:
  - satori://code/trufflehog

#netstat:
#  assertStdoutNotContains: 'LISTEN'
#  execute:
#  - [ apt-get install net-tools -y >>/dev/null; wget $REPO; pip install $(basename "$REPO"); netstat -atupen ]"> plbks/playbook-$(basename "$REPO").yml
    ../../../satori-cli/satori-cli run plbks/playbook-$(basename "$REPO").yml >>/dev/null &
	fi
    CONT=$((CONT+1))
done<<<"$PROJECTS"
