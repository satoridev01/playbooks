while read line; do
    name="`echo $line|awk -F', ' '{print $1}'`"
    uri="`echo $line|awk -F', ' '{print $2}'`"
    filename="`echo $uri|awk -F'/' '{print $NF}'`"
    
    if [ "`echo $filename|grep '.tar.gz$'`" != "" ]; then
        command="tar -zxf"
        directory="`echo $filename|awk -F'.tar.gz' '{print $1}'`"
    elif [ "`echo $filename|grep '.zip$'`" != "" ]; then
        command="unzip"
        directory="`echo $filename|awk -F'.zip' '{print $1}'`"
    elif [ "`echo $filename|grep '.whl$'`" != "" ]; then
        command="unzip"
        directory="`echo $filename|awk -F'.whl' '{print $1}'`"
    fi
    echo "satori-cli run "satori://monitor/ss.yml" --data \"{\"install\":\"wget $uri; $command $filename; cd $directory; python3 setup.py install\"}\""
done<repos
