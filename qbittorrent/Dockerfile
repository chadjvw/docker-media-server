FROM ubuntu:16.10

MAINTAINER Werner Beroux <werner@beroux.com>

ENV MGUID 3864 QUID 583

#RUN apt-get update && apt-get -y install software-properties-common
#RUN apt-add-repository multiverse && apt-get upgrade
RUN buildDeps=' \
         software-properties-common \
	 cmake \
         curl \
         g++ \
         libboost-system-dev \
         libqt4-dev \
         libssl-dev \
         make \
         pkg-config \
         qtbase5-dev \
         qttools5-dev-tools \
    ' \
    && set -x \
    && echo "Install dependencies" \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
         $buildDeps \
         ca-certificates \
         libboost-dev \
         libc6 \
         libgcc1 \
         libqt4-network \
         libqt5network5 \
         libqt5widgets5 \
         libqt5xml5 \
         libqtcore4 \
         libstdc++6 \
         zlib1g \
    && apt-add-repository multiverse \
    && apt-get update \
    && apt-get install -y unrar vim \
    && echo "Download qBittorrent source code" \
    && LIBTORRENT_RASTERBAR_URL=$(curl -L http://www.qbittorrent.org/download.php | grep -Eo 'https?://[^"]*libtorrent[^"]*\.tar\.gz[^"]*' | head -n1) \
    && QBITTORRENT_URL=$(curl -L http://www.qbittorrent.org/download.php | grep -Eo 'https?://[^"]*qbittorrent[^"]*\.tar\.gz[^"]*' | head -n1) \
    && mkdir -p /tmp/libtorrent-rasterbar \
    && mkdir -p /tmp/qbittorrent \
    && curl -L $LIBTORRENT_RASTERBAR_URL | tar xzC /tmp/libtorrent-rasterbar --strip-components=1 \
    && curl -L $QBITTORRENT_URL | tar xzC /tmp/qbittorrent --strip-components=1 \

    && echo "Build and install" \
    && cd /tmp/libtorrent-rasterbar \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make install \

    && cd /tmp/qbittorrent \
    && ./configure --disable-gui \
    && make install \

    && echo "Clean-up" \
    && apt-get purge --auto-remove -y $buildDeps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "Create symbolic links to simplify mounting" \
    && groupadd -g $MGUID media \ 
    && useradd --system --uid $QUID --gid $MGUID -m --shell /usr/sbin/nologin qbittorrent \
    && usermod -a -G media qbittorrent \
    && mkdir -p /home/qbittorrent/.config/qBittorrent \
    && ln -s /home/qbittorrent/.config/qBittorrent /config \

    && mkdir -p /home/qbittorrent/.local/share/data/qBittorrent \
    && ln -s /home/qbittorrent/.local/share/data/qBittorrent /torrents \

    && chown -R qbittorrent:media /home/qbittorrent/ \
 #   && mkdir /default \
 #   && chown -R qbittorrent:qbittorrent /default \
 #   && chmod -R 777 /default \
    && mkdir /downloads \
    && chown -R qbittorrent:media /downloads

# Default configuration file.
COPY qBittorrent.conf /default/qBittorrent.conf
COPY entrypoint.sh /
COPY unrar.sh /

VOLUME /config
VOLUME /torrents
VOLUME /downloads

EXPOSE 8080
EXPOSE 56748 

USER qbittorrent

ENTRYPOINT ["/entrypoint.sh"]
CMD ["qbittorrent-nox"]
