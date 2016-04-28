#!/bin/sh

echo 'StartTime: ' `date`
# 输入需要扫描的IP网段的文件名
filename="input.txt"
# 统计文件行数
line_num=0
# 设置并发数量
mprocess=5
# 开始扫描日期 20150831
date=`date "+%Y%m%d"`
# 备份本次扫描的扫描源文件
cp $filename ./result/$filename.$date

# 循环读取扫描文件
while read line
do
  line_num=$(($line_num+1))
  echo $line_num $line

  # 启动nmap，扫描一个网段
  nmap -n -sn $line --append-output -oG ./result/nmap.out.log > /dev/null &

  # 循环等待nmap执行
  while true
  do
    # 统计nmap进程的数量
    ps=`ps -ef | grep -v grep | grep nmap | wc -l`

    # 如果nmap进程数量，达到最大并发数，sleep 3秒，继续循环
    if [ $ps -ge $mprocess ]
    then
      echo 'full nmap...'
      sleep 3

    # 如果没到达到最大并发数，结束等待循环，新建一个nmap进程
    else
      echo 'new nmap...'
      break
    fi
  done

done < $filename

# 循环等待全部nmap进程结束
while true
do
  ps=`ps -ef | grep -v grep | grep nmap | wc -l`
  if [ 0 -eq $ps ]
  then
    echo 'finish..'
    break
  else
    sleep 3
  fi
done

echo ''
echo 'EndTime: ' `date`
