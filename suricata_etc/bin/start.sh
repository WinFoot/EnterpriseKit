#!/bin/sh

#suricata -c /etc/suricata/suricata.yaml -i eth1

echo 'kill suricata process...'
/bin/ps aux |grep suricata |grep -v grep | grep -v '/etc/suricata/bin/start.sh' |awk '{print $2}' |/usr/bin/xargs -n 1 kill -9 && sleep 0.5
/sbin/ifconfig eth1 up
/sbin/ifconfig eth1 promisc

echo 'suricata run.'
conf_str='-D --pfring-int=eth1 --pfring-cluster-id=99 --pfring-cluster-type=cluster_flow'
echo 'suricata' $conf_str
conf_file='/etc/suricata/suricata.yaml'
echo 'suricata' $conf_file
/usr/bin/suricata -c $conf_file $conf_str > /dev/null

echo 'logstash run.'
conf_etc='/etc/suricata/logstash.conf'
echo 'logstash' $conf_etc
conf_out='/var/log/logstash.log'
echo 'logstash' $conf_out
nohup /opt/logstash-1.5.0/bin/logstash -f $conf_etc -l $conf_out > /dev/null &

echo 'finish.'
