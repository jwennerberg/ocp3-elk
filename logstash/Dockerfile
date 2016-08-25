FROM rhel7:latest

MAINTAINER Jonas Nordell <jnordell@redhat.com>

LABEL \
      # Labels consumed by Red Hat build service.
      Name="logstash" \
      Version="1.0" \
      Release="1" \
      Architecture="x86_64"

ENV HOME=/opt/app-root/src

RUN yum -y --disablerepo=* --enablerepo=rhel-7-server-rpms install yum-utils deltarpm

RUN yum-config-manager --disable \*-eus-* \*-htb-* \*-ha-* \*-rt-* \*-lb-* \*-rs-* \*-sap-* \*-aus* \*-sjis* \*-nfv* && \
    INSTALL_PKGS="which git tar wget hostname sysvinit-tools util-linux bsdtar unzip net-tools iproute \
    socat ethtool device-mapper iptables tree findutils nmap-ncat e2fsprogs xfsprogs lsof hostname" && \
    yum -y update && \
    yum -y install --setopt=tsflags=nodocs ${INSTALL_PKGS} && \
    yum clean all

COPY logstash.repo /etc/yum.repos.d/logstash.repo

RUN groupadd -r kibana && useradd -r -m -g kibana kibana

# install the RPMs in a separate step so it can be cached
RUN yum install -y --setopt=tsflags=nodocs logstash openssl java-1.8.0-openjdk-headless && \
    yum clean all

COPY start_logstash.sh logstash.conf /opt/app-root/

RUN chown -R 1001:1001 /opt/app-root

ENV PATH /opt/logstash/bin:$PATH
ENV JAVA_HOME /usr/lib/jvm/java-openjdk:$JAVA_HOME
ENV JAVACMD /usr/bin/java

USER 1001

EXPOSE 8080 9292

CMD ["/opt/app-root/start_logstash.sh"]

