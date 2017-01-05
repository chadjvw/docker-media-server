FROM ubuntu:16.04 

ENV DEBIAN_FRONTEND noninteractive MGUID 3864 SUID 584

RUN locale-gen en_US en_US.UTF-8

RUN useradd --system --uid $SUID -M --shell /bin/nologin sonarr \
    && groupadd -g $MGUID media \
    && usermod -a -G media sonarr \
    && mkdir /download \
    && mkdir /tv \
    && mkdir /opt/NzbDrone \
    && chown -R sonarr:media /download \
    && chown -R sonarr:media /tv \
    && chmod -R 775 /download \
    && chmod -R 775 /tv \
    && apt-get update -q \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC \
    && echo "deb http://apt.sonarr.tv/ master main" | sudo tee /etc/apt/sources.list.d/sonarr.list \
    && apt-get update -q \
    && apt-get install -y --no-install-recommends nzbdrone \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && chown -R sonarr:media /opt/NzbDrone \
    && chmod -R 775 /opt/NzbDrone

VOLUME /home/sonarr/.config/NzbDrone
VOLUME /download
VOLUME /tv

COPY *.sh /
RUN chmod 777 /update.sh

EXPOSE 8989 

USER sonarr

ENTRYPOINT ["mono", "--debug", "/opt/NzbDrone/NzbDrone.exe"]
