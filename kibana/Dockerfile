FROM rhel7:latest

MAINTAINER Jonas Nordell <jnordell@redhat.com>

USER 0

LABEL \
      # Labels consumed by Red Hat build service.
      Name="kibana" \
      Version="1.0" \
      Release="1" \
      Architecture="x86_64"

ENV KIBANA_MAJOR 4.5
ENV KIBANA_VERSION 4.5.0
ENV HOME=/opt/app-root/src
ENV ELASTICSEARCH_SERVICE_HOST=ocp3-elasticsearch

RUN groupadd -r kibana && useradd -r -m -g kibana kibana

# Fix per https://bugzilla.redhat.com/show_bug.cgi?id=1192200 
RUN yum -y install deltarpm yum-utils --disablerepo=*-eus-* --disablerepo=*-htb-* \
    --disablerepo=*-ha-* --disablerepo=*-rt-* --disablerepo=*-lb-* --disablerepo=*-rs-* --disablerepo=*-sap-*

RUN yum-config-manager --disable *-eus-* *-htb-* *-ha-* *-rt-* *-lb-* *-rs-* *-sap-* && \
    yum -y update && \
    yum -y install --setopt=tsflags=nodocs lsof witch tar wget unzip net-tools iproute hostname sysvinit-tools util-linux bsdtar && \
    yum clean all

ADD kibana.repo /etc/yum.repos.d/kibana.repo
# install the RPMs in a separate step so it can be cached
RUN rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch && \
    yum install -y --setopt=tsflags=nodocs \
                kibana && \
    yum clean all

ENV PATH /opt/kibana/bin:$PATH

RUN chown -R kibana:kibana /opt/kibana

COPY docker-entrypoint.sh /

RUN chmod -R og+w /opt/kibana

EXPOSE 5601
USER 1000

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["kibana"]
