FROM python:slim

ENV FUID 585 MGUID 3864

RUN pip install --upgrade pip \
	&& pip install --upgrade --force-reinstall \
	flexget \
	&& mkdir /scripts

ADD init.sh /scripts/init.sh
RUN chmod +x /scripts/init.sh 

VOLUME /config
VOLUME /data

RUN useradd -u $FUID -U -s /bin/false flexget
RUN usermod -G users flexget

CMD ["/scripts/init.sh"]
