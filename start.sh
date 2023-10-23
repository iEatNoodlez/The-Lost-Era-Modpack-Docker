#!/bin/sh

set -e
serverjar="serverstarter-2.3.1.jar"

cd /data

if [ ! -f "$serverjar" ]; then
	cp -rf /tmp/lost-era/* .
	chmod a+x startserver.sh
fi
echo "eula=true" > eula.txt

if [[ -n "$MOTD" ]]; then
    sed -i "/motd\s*=/ c motd=$MOTD" /data/server.properties
fi
if [[ -n "$LEVEL" ]]; then
    sed -i "/level-name\s*=/ c level-name=$LEVEL" /data/server.properties
fi
if [[ -n "$OPS" ]]; then
    echo $OPS | awk -v RS=, '{print}' >> ops.txt
fi

sh ./startserver.sh