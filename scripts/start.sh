#!/bin/bash

echo "Running start script..."

if [ ! -e installed ]
    then
        ./install.sh
fi

# Check for changes in timezone
if [ $(cat /etc/timezone) != "$TZ" ]
    then
        echo "Timezone changed. Setting new timezone: $TZ"
        ln -fs /usr/share/zoneinfo/$TZ /etc/localtime
        dpkg-reconfigure -f noninteractive tzdata
fi

echo "Starting server..."
./bedrock_server