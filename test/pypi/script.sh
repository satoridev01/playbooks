#!/bin/bash

# General settings
PYPI_PAGES=2

# Global variables
PROJECTS=""
CONT=1

# Get the project names
while [ $CONT -le $PYPI_PAGES ]; do 
  PROJECTS="$PROJECTS
`curl -s "https://pypi.org/search/?c=Development+Status+%3A%3A+5+-+Production%2FStable&page=$CONT"|grep "package-snippet__name"|awk -F'>' '{print $2}'|awk -F'<' '{print $1}'`"
  CONT=$((CONT+1))
done

# Get the project repos
while read PROJECT; do
	REPO=`curl -s "https://pypi.org/project/$PROJECT/"|grep "file__card" -A2 -m1|grep "a href"|awk -F'"' '{print $2}'`
	if [ "$REPO" != "" ]; then
		#echo "$PROJECT, $OUTPUT"
    echo "settings:
  name: pypi

install-$PROJECT:
  assertReturnCode: 0
  execute:
#  - [ apt-get install git; pip install truffleHog ]
  - [ wget $REPO; pip install $(basename "$REPO") ]

#detect-secrets:
#  assertStdoutContains: 'fruta'
#  execute:
#  - [ apt-get install git; pip install detect-secrets; detect-secrets scan ] 

#import:
#  - satori://devops/netstat2
#trufflehog:
#  assertStdoutContains: 'fruta'
#  execute:
#  - [ trufflehog ./ ]

#netstat:
#  assertStdoutNotContains: 'LISTEN'
#  execute:
#  - [ apt-get install net-tools ; netstat -atupen ]"> playbook.yml
    ../../../satori-cli/satori-cli run playbook.yml &
    # break
	fi
done <<< "$PROJECTS"
