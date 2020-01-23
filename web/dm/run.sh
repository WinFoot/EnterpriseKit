#!/bin/sh

PWD=$(dirname $0)

# Domain
parallel --jobs 20 ./domain/domain.sh ::: global.com :::: ${PWD}/lib/wd.txt :::: ${PWD}/lib/wd.txt

# Dir
# awk '{print $2}' ./domain/domain.log | parallel --jobs 50 ./dir/dir.sh :::: - :::: ${PWD}/lib/wd.txt
