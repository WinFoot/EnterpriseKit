#!/bin/bash

su nobody -c "nohup /backup/elk/elasticsearch-2.0.0/bin/elasticsearch -d > /backup/elk/run_elk/logs/elastic.nohup &"
su nobody -c "nohup /backup/elk/kibana-4.2.1-linux-x64/bin/kibana serve > /backup/elk/run_elk/logs/kibana.nohup &"

nohup /backup/elk/logstash-2.0.0/bin/logstash agent -f /backup/elk/run_elk/conf/syslog.conf > /backup/elk/run_elk/logs/syslog.log &
nohup /backup/elk/logstash-2.0.0/bin/logstash agent -f /backup/elk/run_elk/conf/secure.conf > /backup/elk/run_elk/logs/secure.log &
nohup /backup/elk/logstash-2.0.0/bin/logstash agent -f /backup/elk/run_elk/conf/bash.conf    > /backup/elk/run_elk/logs/bash.log &
nohup /backup/elk/logstash-2.0.0/bin/logstash agent -f /backup/elk/run_elk/conf/command.conf > /backup/elk/run_elk/logs/command.log &

