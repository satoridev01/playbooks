#!/bin/bash

# General settings
MAX_PYPI_PAGES=1
PLAYBOOKS_NAME="pypi-$RANDOM"
CONT=1

# Get the project names
PYPI_PROJECT_NAMES=""
CONT=1
while [ $CONT -le $MAX_PYPI_PAGES ]; do 
  PYPI_PROJECT_NAMES="$PYPI_PROJECT_NAMES\n`curl -s "https://pypi.org/search/?c=Development+Status+%3A%3A+5+-+Production%2FStable&page=$CONT" | grep "package-snippet__name" | awk -F'>' '{print $2}' | awk -F'<' '{print $1}'`"
  CONT=$((CONT+1))
done

# Run a Satori Playbook against each repo
CONT=0
while read PROJECT; do
	REPO=`curl -s "https://pypi.org/project/$PROJECT/" | grep "file__card" -A2 -m1 | grep "a href" | awk -F'"' '{print $2}' | grep "tar.gz"`
	if [ "$REPO" != "" ]; then
    BASENAME=$(basename "$REPO")
    echo "$CONT) name: $NAME - project: $PROJECT - repo: $REPO"
    echo "settings:
  name: $PLAYBOOKS_NAME

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
  - [ grep '\$(keyword)' * -r ]

import:
  - satori://code/trufflehog
  - satori://search/ip_addresses
  - satori://secdevops/open_ports"> plbks/playbook-$BASENAME.yml
    satori-cli run plbks/playbook-$(basename "$REPO").yml >>/dev/null &
    exit
	fi
    CONT=$((CONT+1))
done<<<"$PROJECTS"
