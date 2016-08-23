FROM rhel7:latest

MAINTAINER Jonas Nordell <jnordell@redhat.com>

USER 0

LABEL \
      # Labels consumed by Red Hat build service.
      Name="logstash" \
      Version="1.0" \
      Release="1" \
      Architecture="x86_64"

ENV HOME=/opt/app-root/src

RUN groupadd -r kibana && useradd -r -m -g kibana kibana

# Fix per https://bugzilla.redhat.com/show_bug.cgi?id=1192200 
RUN yum -y install deltarpm yum-utils --disablerepo=*-eus-* --disablerepo=*-htb-* \
    --disablerepo=*-ha-* --disablerepo=*-rt-* --disablerepo=*-lb-* --disablerepo=*-rs-* --disablerepo=*-sap-*

RUN yum-config-manager --disable *-eus-* *-htb-* *-ha-* *-rt-* *-lb-* *-rs-* *-sap-* && \
    yum -y update && \
    yum -y install --setopt=tsflags=nodocs lsof witch tar wget unzip net-tools iproute hostname sysvinit-tools util-linux bsdtar && \
    yum clean all

ADD logstash.repo /etc/yum.repos.d/logstash.repo

# install the RPMs in a separate step so it can be cached
RUN yum install -y --setopt=tsflags=nodocs logstash openssl java-1.8.0-openjdk && \
    yum clean all

ADD logstash.yml /opt/app-root

RUN chown -R 1001:1001 /opt/app-root

USER 1001

EXPOSE 8080

CMD ["/usr/bin/logstash","agent","-f","/opt/app-root/logstash.yml"]

