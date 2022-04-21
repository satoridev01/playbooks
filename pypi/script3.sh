#!/bin/bash
# while read line; do ./script2.sh $line; done<paquetes >> repos

playbook="""tests:
	install:
		# Download source code
		wget {$repo}
		tar -zxf $(basename "$repo") -C code

		# Download and Install Dawgmon
		git clone https://github.com/anvilsecure/dawgmon.git
		dawgmon/python3 setup.py install
		dawgmon/dawgmon -gfA

		# Run source code
		python3 code/setup.py install
"""

while read line; do 
	if [ "`echo $line|grep ','`" != "" ]; then
		pypy=`echo $line|awk -F',' '{print $1}'`
		repo=`echo $line|awk -F',' '{print $2}'|tr -d ' '`
		echo satori-cli --name "$pypy" --playbook "$playbook" --data "{\"repo\", \"$repo\"}" --tag "pypi"
	else
		echo "Error: $line"
	fi
done<repos
