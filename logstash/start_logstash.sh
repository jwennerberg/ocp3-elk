#!/bin/bash

exec /opt/logstash/bin/logstash agent --verbose -f /opt/app-root/logstash.yml  >> /var/tmp/logstash.log 2>&1
