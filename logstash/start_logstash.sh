#!/bin/bash

exec /opt/logstash/bin/logstash agent -f /opt/app-root/logstash.conf  >> /var/tmp/logstash.log 2>&1
