FROM rhel7:latest

MAINTAINER Jonas Nordell <jnordell@redhat.com>

USER 0

LABEL \
      # Labels consumed by Red Hat build service.
      Name="docker-base/base" \
      Version="1.0" \
      Release="1" \
      Architecture="x86_64"

ENV ELASTICSEARCH_MAJOR 2.3 \
    ELASTICSEARCH_VERSION 2.3.2 \
    ELASTICSEARCH_REPO_BASE http://packages.elastic.co/elasticsearch/2.x/centos \
    HOME=/opt/app-root/src

# Fix per https://bugzilla.redhat.com/show_bug.cgi?id=1192200 
RUN yum -y install deltarpm yum-utils --disablerepo=*-eus-* --disablerepo=*-htb-* \
    --disablerepo=*-ha-* --disablerepo=*-rt-* --disablerepo=*-lb-* --disablerepo=*-rs-* --disablerepo=*-sap-*

RUN yum-config-manager --disable *-eus-* *-htb-* *-ha-* *-rt-* *-lb-* *-rs-* *-sap-* && \
    yum -y update && \
    yum -y install --setopt=tsflags=nodocs lsof witch tar wget unzip net-tools iproute && \
    yum clean all

ADD elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo
# install the RPMs in a separate step so it can be cached
RUN rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch && \
    yum install -y --setopt=tsflags=nodocs \
                java-1.8.0-openjdk-headless \
                elasticsearch && \
    yum clean all

WORKDIR /usr/share/elasticsearch

ADD elasticsearch.yml logging.yml /usr/share/elasticsearch/config/
ADD install.sh ${HOME}/
RUN ${HOME}/install.sh
ADD run.sh ${HOME}/

WORKDIR ${HOME}
EXPOSE 9200 9300
USER 1000
CMD ["sh", "/opt/app-root/src/run.sh"]
