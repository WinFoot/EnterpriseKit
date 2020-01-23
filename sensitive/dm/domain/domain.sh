#!/bin/sh

PWD=$(dirname $0)
mkdir -p $PWD/output/
logfile=$PWD/domain.log

domain=$1
shift 1
ARGLIST="$*"
sub=${ARGLIST//\ /\.}

url="${sub}.${domain}"
body_file="$PWD/output/$url"

curl  --referer $url --user-agent 'Chrome/54.0 (Windows NT 10.0)' --connect-timeout 10 -m 20 -o $body_file $url
if [ -f "$body_file" ]; then
  md5=$(md5sum $body_file | awk '{print $1}')
  echo "$md5 $url" >> $logfile
fi

