FROM wernight/qbittorrent:latest

USER root

RUN apk update

RUN apk add ca-certificates coreutils tzdata

RUN echo '@testing http://dl-4.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache \
        java-cacerts \
        java-jna \
        libzen \
        libmediainfo \
        openjdk11-jre-headless \
        chromaprint \
        chromaprint-dev

# Install filebot
WORKDIR /usr/local/bin
COPY FileBot_4.8.5-portable.tar.xz filebot.tar.xz
RUN ls -lah
RUN tar xvf filebot.tar.xz
RUN chmod +x filebot.sh
RUN mv filebot.sh filebot
# RUN filebot --help

RUN filebot -script fn:sysinfo
