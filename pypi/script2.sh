#!/bin/bash
if [ "$1" != "" ]; then
	#OUTPUT=`curl -s "https://pypi.org/project/$1/"|grep "github-repo-info hidden" -m1|awk -F'"' '{print $4}'|awk -F'https://api.github.com/repos' '{print "https://github.com"$2}'`
	#if [ "$OUTPUT" == "" ]; then
	#	OUTPUT=`curl -s "https://pypi.org/project/$1/"|grep "Contribute on GitHub"|awk -F'"' '{print $2}'`
	#fi
	OUTPUT=`curl -s "https://pypi.org/project/$1/"|grep "file__card" -A2 -m1|grep "a href"|awk -F'"' '{print $2}'`
	if [ "$OUTPUT" != "" ]; then
		echo "$1, $OUTPUT"
	else
		echo "Error: $1" 1>&2
	fi
fi
