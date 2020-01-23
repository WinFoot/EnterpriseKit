#并发执行
#nohup parallel --jobs 50 './solr.py {1} ' :::: target/input_80 &
#独立运行
./solr.py 139.59.56.119