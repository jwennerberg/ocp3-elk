#!/bin/bash

exec /opt/logstash/bin/logstash agent -f /opt/app-root/logstash.yml  >> /opt/app-root/logstash.log 2>&1
