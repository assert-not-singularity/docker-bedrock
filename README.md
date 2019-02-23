This is a ready-to-use image of the Minecraft Bedrock Server. 

Just mount the exposed volume ``/data/`` to your desired persistent directory ``/your-mount`` and make sure that the TCP and UDP ports 19132 (IPv4) and 19133 (IPv6) are forwarded to the container (a total of four ports for v4 & v6). Use the environment variable ``TZ`` to set [your time zone](https://en.wikipedia.org/wiki/Tz_database).

The image uses symlinks to provide easy access to the configs ``permissions.json``, ``server.properties`` and ``whitelist.json``. **Notice:** Because of this approach, you initially need to copy [these three files](https://github.com/assert-not-singularity/docker-bedrock/blob/master/config) to ``/your-mount/config/``.