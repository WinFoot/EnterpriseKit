#!/bin/sh

date=`date --date="1 days ago" +"%Y-%m-%d"`
file='/home/suricata/suricata_log/http.log'
backup='/home/suricata/suricata_log/log/http.log.'$date
mv $file $backup
/bin/sh /etc/suricata/bin/start.sh
