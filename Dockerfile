FROM openjdk:8-jdk

MAINTAINER Noodlez <me@no-reply.com>

RUN apt-get install -y wget unzip && \
 addgroup --gid 1234 minecraft && \
 adduser --disabled-password --home=/data --uid 1234 --gid 1234 --gecos "minecraft user" minecraft

RUN mkdir /tmp/feed-the-beast && cd /tmp/feed-the-beast && \ 
## pull file redirected from https://www.curseforge.com/minecraft/modpacks/skyfactory-4/download/3012800/file 
 wget -c https://qpkg.app/TheLostEraModpack-1.6.2.zip -O TheLostEraModpack-1.6.4.zip && \
 unzip TheLostEraModpack-1.6.4.zip -d /tmp/lost-era && \
 chmod -R 777 /tmp/lost-era && \
 chown -R minecraft /tmp/lost-era

COPY start.sh /start.sh
RUN chmod +x /start.sh

USER minecraft

VOLUME /data
WORKDIR /data

EXPOSE 25565

CMD ["/start.sh"]

ENV MOTD "A Minecraft (Lost Era 1.6.4) Server Powered by Noodlez"
ENV LEVEL world
ENV JVM_OPTS "-Xms4048m -Xmx4048m"
