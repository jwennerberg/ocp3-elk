FROM rhel7:latest

MAINTAINER Jonas Nordell <jnordell@redhat.com>

LABEL \
      # Labels consumed by Red Hat build service.
      Name="kibana" \
      Version="1.0" \
      Release="1" \
      Architecture="x86_64"

ENV KIBANA_MAJOR 4.5
ENV KIBANA_VERSION 4.5.0
ENV HOME=/opt/app-root/src
ENV ELASTICSEARCH_SERVICE_HOST=elasticsearch

RUN yum -y --disablerepo=* --enablerepo=rhel-7-server-rpms install yum-utils deltarpm

RUN yum-config-manager --disable \*-eus-* \*-htb-* \*-ha-* \*-rt-* \*-lb-* \*-rs-* \*-sap-* \*-aus* \*-sjis* \*-nfv* && \
    INSTALL_PKGS="which git tar wget hostname sysvinit-tools util-linux bsdtar unzip net-tools iproute \
    socat ethtool device-mapper iptables tree findutils nmap-ncat e2fsprogs xfsprogs lsof hostname" && \
    yum -y update && \
    yum -y install --setopt=tsflags=nodocs ${INSTALL_PKGS} && \
    yum clean all

RUN groupadd -r kibana && useradd -r -m -g kibana kibana

COPY kibana.repo /etc/yum.repos.d/kibana.repo
# install the RPMs in a separate step so it can be cached
RUN rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch && \
    yum install -y --setopt=tsflags=nodocs kibana \
    yum clean all

ENV PATH /opt/kibana/bin:$PATH

RUN chown -R kibana:kibana /opt/kibana

COPY docker-entrypoint.sh /

RUN chmod -R og+w /opt/kibana

EXPOSE 5601

USER 1001

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["kibana"]
