FROM ubuntu:latest

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		wget \
	&& rm -rf /var/lib/apt/lists/*

ENV IPG_PORT 9000
ENV GOSU_VERSION 1.9
RUN set -x \
    && apt-get update && apt-get install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/* \
    && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && apt-get purge -y --auto-remove ca-certificates wget

RUN apt-get update
RUN apt-get -y install x11-common software-properties-common
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update
RUN apt-get -y install openjdk-7-jdk

RUN mkdir -p /opt/build/jars
RUN mkdir -p /opt/build/keys

COPY jars/* /opt/build/jars/
COPY keys/* /opt/build/keys/
COPY ./StartService.sh /opt/build/
RUN chmod 775 /opt/build/StartService.sh

VOLUME ["/var/log/amex-nationstrust-ipg-client"]
WORKDIR /opt/build/

# COPY docker-entrypoint.sh /usr/local/bin/
# ENTRYPOINT ["docker-entrypoint.sh"]

CMD /bin/bash ./StartService.sh -keypath/opt/build/keys/ -logpath/var/log/amex-nationstrust-ipg-client/ -port$IPG_PORT
