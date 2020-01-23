#!/bin/sh

PWD=$(dirname $0)
mkdir -p $PWD/output/
logfile=$PWD/dir.log

domain=$1
shift 1
ARGLIST="$*"
dir=${ARGLIST//\ /\/}

url="${domain}/${dir}/"
#echo $url
body_file="${PWD}/output/${url//\//_}"
curl  --referer $url --user-agent 'Chrome/54.0 (Windows NT 10.0)' --connect-timeout 10 -m 20 -o $body_file $url
if [ -f "$body_file" ]; then
  md5=$(md5sum $body_file | awk '{print $1}')
  echo "$md5 $url" >> $logfile
fi

#FILENAME='result.log'
#cat $FILENAME | while read LINE  
#do  
#done  
