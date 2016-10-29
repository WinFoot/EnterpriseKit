
file='/home/suricata/suricata_log/http.log'
#file='/home/suricata/suricata_log/a.txt'
outdir='/home/suricata/suricata_log/analyze/'
date=`date +"%Y-%m-%d"`

echo 'Src IP'
output=$outdir'src_ip.'$date
awk '{print $2}' $file | sort | uniq -c | sort -nr > $output

echo 'Dst IP Port'
output=$outdir'dst_ipport.'$date
awk '{print $5":"$6}' $file | sort | uniq -c | sort -nr > $output

echo 'Hostname'
output=$outdir'hostname.'$date
awk -F ' \\\[\\\*\\\+\\\.\\\] ' '{print $2}' $file 2> /dev/null | sort | uniq -c | sort -nr > $output

echo 'User-agent'
output=$outdir'useragent.'$date
awk -F ' \\\[\\\*\\\+\\\.\\\] ' '{print $5}' $file 2> /dev/null | sort | uniq -c | sort -nr > $output

#echo 'Url'
#output=$outdir'url.'$date
#awk -F ' \\\[\\\*\\\+\\\.\\\] | ' '{print "http://"$11":"$6$12}' $file 2> /dev/null > $output

