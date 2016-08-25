FROM rhel7:latest

MAINTAINER Jonas Nordell <jnordell@redhat.com>

LABEL \
      # Labels consumed by Red Hat build service.
      Name="elasticsearch" \
      Version="1.0" \
      Release="1" \
      Architecture="x86_64"

ENV  ELASTICSEARCH_MAJOR 2.3 
ENV  ELASTICSEARCH_VERSION 2.3.2 
ENV  ELASTICSEARCH_REPO_BASE http://packages.elastic.co/elasticsearch/2.x/centos 
ENV  HOME=/opt/app-root/src

RUN yum -y --disablerepo=* --enablerepo=rhel-7-server-rpms install yum-utils deltarpm

RUN yum-config-manager --disable \*-eus-* \*-htb-* \*-ha-* \*-rt-* \*-lb-* \*-rs-* \*-sap-* \*-aus* \*-sjis* \*-nfv* && \
    INSTALL_PKGS="which git tar wget hostname sysvinit-tools util-linux bsdtar unzip net-tools iproute \
    socat ethtool device-mapper iptables tree findutils nmap-ncat e2fsprogs xfsprogs lsof hostname" && \
    yum -y update && \
    yum -y install --setopt=tsflags=nodocs ${INSTALL_PKGS} && \
    yum clean all \

COPY elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo

RUN rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch && \
    yum install -y --setopt=tsflags=nodocs java-1.8.0-openjdk-headless elasticsearch && \
    yum clean all && \
    rm -rf /var/cache/yum/*

COPY logging.yml elasticsearch.yml /usr/share/elasticsearch/config/
COPY install.sh ${HOME}/
RUN ${HOME}/install.sh
COPY run.sh ${HOME}/

WORKDIR ${HOME}
EXPOSE 9200 9300
USER 1001

CMD ["sh", "/opt/app-root/src/run.sh"]
