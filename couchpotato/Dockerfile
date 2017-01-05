FROM ubuntu:16.04 

ENV DEBIAN_FRONTEND noninteractive MGUID 3864 CUID 585

RUN locale-gen en_US en_US.UTF-8

RUN buildDep='python-pip python-dev build-essential' \
    && useradd --system --uid $CUID -M --shell /bin/nologin cp \
    && groupadd -g $MGUID media \
    && usermod -a -G media cp \
    && mkdir /config \
    && mkdir /data \
    && chown -R cp:media /config \
    && chown -R cp:media /data \
    && apt-get update -q \
    && apt-get install -y git-core  libffi-dev libssl-dev libxslt1-dev libxml2-dev python $buildDep \
    && git clone https://github.com/CouchPotato/CouchPotatoServer.git /opt/couchpotato \
    && pip install lxml pyopenssl \
    && pip install pyopenssl --upgrade \
    && apt-get purge --auto-remove -y $buildDeps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


VOLUME /config
VOLUME /data

EXPOSE 5050

USER cp

ENTRYPOINT ["python", "/opt/couchpotato/CouchPotato.py"]
CMD ["--data_dir=/config"]
