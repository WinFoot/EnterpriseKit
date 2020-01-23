
log_nmap='nmap.log'
log_live='live.log'
cmd_nmap="nmap -n -sn --append-output --min-hostgroup 64 --min-parallelism 64 -oG $log_nmap"
cmd_curl="curl -o dbs/*.body -D dbs/*.head *"

mkdir -p dbs
rm dbs/*
rm *.log

./parallel.sh -j 50 "$cmd_nmap" `cat net.txt`

grep 'Status: Up' $log_nmap | awk '{print $2}' > $log_live

./parallel.sh -j 50 -r "$cmd_curl" `cat $log_live`
