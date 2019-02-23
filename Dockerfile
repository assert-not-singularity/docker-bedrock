FROM ubuntu:latest

LABEL maintainer="github.com/assert-not-singularity"

# Download packages and server binaries
RUN apt-get update && apt-get install -y libcurl4 libssl1.1 nano tzdata unzip wget
RUN wget https://minecraft.azureedge.net/bin-linux/bedrock-server-1.9.0.15.zip -qO bedrock-server.zip
RUN unzip bedrock-server.zip -d /bedrock-server && rm bedrock-server.zip

# Set timezone
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

VOLUME ["/data"]

# Create symlinks to behaviour & resource packs and world data
RUN ln -s /data/behavior_packs /bedrock-server/behavior_packs && \
    ln -s /data/resource_packs /bedrock-server/resource_packs && \
    ln -s /data/worlds /bedrock-server/worlds

# Create symlinks to mounted config files
RUN ln -sfb /data/config/permissions.json /bedrock-server/permissions.json && \
    ln -sfb /data/config/server.properties /bedrock-server/server.properties && \
    ln -sfb /data/config/whitelist.json /bedrock-server/whitelist.json

# Expose Ports for IPv4
EXPOSE 19132/tcp
EXPOSE 19132/udp

# Expose Ports for IPv6
EXPOSE 19133/tcp
EXPOSE 19133/udp

WORKDIR /bedrock-server
ENV LD_LIBRARY_PATH=/.
CMD ./bedrock_server