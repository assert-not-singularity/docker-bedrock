This is a ready-to-use image of the Minecraft Bedrock Server. 

**Important:** Before starting the server the first time, mount the exposed volume `/data/` to your desired persistent directory `/your-mount` and make sure that the TCP and UDP ports 19132 (IPv4) and 19133 (IPv6) are forwarded to the container (a total of four ports for v4 & v6). Use the environment variable `TZ` to set [your time zone](https://en.wikipedia.org/wiki/Tz_database).

The image uses symlinks to provide easy access to the configs `permissions.json`, `server.properties` and `whitelist.json`. 

**Notice:** It is not required to copy the config files to `/your-mount/config/` anymore. This is done by the newly added installation script.

**Breaking changes:** If you're importing the image using an existing configuration, please make sure to change the start `CMD` from `./bedrock_server` to `./start.sh`!