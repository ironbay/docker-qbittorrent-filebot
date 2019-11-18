FROM wernight/qbittorrent:latest

USER root

RUN echo '@edgecommunity http://dl-4.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories 
RUN echo '@edgetesting http://dl-4.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories 
RUN apk update

RUN apk add ca-certificates coreutils tzdata
RUN apk add openjdk11 --repository=http://dl-4.alpinelinux.org/alpine/edge/community/

RUN apk add libmediainfo chromaprint chromaprint-dev

RUN apk add --no-cache \
        java-cacerts \
        java-jna \
        libzen

# Install filebot
WORKDIR /usr/local/bin
COPY FileBot_4.8.5-portable.tar.xz filebot.tar.xz
RUN ls -lah
RUN tar xvf filebot.tar.xz
RUN chmod +x filebot.sh
RUN mv filebot.sh filebot
# RUN filebot --help

RUN filebot -script fn:sysinfo
