#!/bin/bash

exec /opt/logstash/bin/logstash agent -f /opt/app-root/logstash.yml  >> /var/tmp/logstash.log 2>&1
