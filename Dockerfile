FROM ubuntu:latest

LABEL maintainer="github.com/assert-not-singularity"

# Download packages and server binaries
RUN apt-get update && apt-get install -y libcurl4 libssl1.1 nano tzdata unzip wget
RUN wget https://minecraft.azureedge.net/bin-linux/bedrock-server-1.11.0.23.zip -qO bedrock-server.zip
RUN unzip bedrock-server.zip -d /bedrock-server && rm bedrock-server.zip

# Set standard timezone
ENV TZ=Europe/Berlin

# Copy Shell scripts
COPY scripts/* /bedrock-server/

VOLUME ["/data"]

WORKDIR /bedrock-server

# Perform all commands in one RUN
# Make scripts executable
RUN find . -name '*.sh' -type f -maxdepth 1 | xargs chmod +x && \
# Create symlinks to behaviour & resource packs and world data
    ln -s /data/behavior_packs behavior_packs && \
    ln -s /data/resource_packs resource_packs && \
    ln -s /data/worlds worlds && \
# Create symlinks to mounted config files
    mkdir tmp && \
    mv -t tmp/ permissions.json server.properties whitelist.json && \ 
    ln -sfb /data/config/permissions.json permissions.json && \
    ln -sfb /data/config/server.properties server.properties && \
    ln -sfb /data/config/whitelist.json whitelist.json

# Expose Ports for IPv4
EXPOSE 19132/tcp
EXPOSE 19132/udp

# Expose Ports for IPv6
EXPOSE 19133/tcp
EXPOSE 19133/udp

ENV LD_LIBRARY_PATH=/.
CMD ./start.sh