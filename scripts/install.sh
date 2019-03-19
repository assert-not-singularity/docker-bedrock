#!/bin/bash

echo "Running install script..."

# Move config files to now mounted volume
cd /bedrock-server/
if [ ! -d /data/config ]
    then
        echo "No config directory found."
        echo "Creating config files for first-time use..."
        mkdir /data/config/
        mv -t /data/config/ tmp/permissions.json tmp/server.properties tmp/whitelist.json
fi

# Create dir for sample world
if [ ! -d /data/worlds ]
    then
    echo "No world directory found."
    echo "Creating new directory for worlds..."
    mkdir /data/worlds
fi

rm -r tmp/

echo "Install script completed."

# Set marker that this script ran once
touch installed
