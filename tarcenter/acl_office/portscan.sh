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
    # 输出存活主机文件 格式 ip
    #awk '/^[^#]/{print $2}' ./result/nmap.out.log > ./result/ips.txt.$date
    grep 'Status: Up' ./result/nmap.out.log | awk '/^[^#]/{print $2}' > ./result/ips.txt.$date
    # 删除临时文件
    rm -rf ./result/nmap.out.log
    echo 'finish..'
    break
  else
    sleep 3
  fi
done

# 扫描存活主机的65535端口
masscan -p1-65535 -iL ./result/ips.txt.$date --rate 10000 -oG ./result/masscan.out.log
#masscan -p1-1024 -iL ./result/ips.txt.$date --rate 10000 -oG ./result/masscan.out.log
# 输出开放端口文件 格式ip:port
awk -F '[ |/]' '/^[^#]/{print $2":"$4}' ./result/masscan.out.log > ./result/ports.txt.$date
# 删除临时文件
rm -rf ./result/masscan.out.log

# nmap 进行端口协议识别
filename='./result/ports.txt.'$date

# 循环读取扫描文件
while read line
do
  line_num=$(($line_num+1))
  echo $line_num $line
  ip=`echo "$line" | awk -F : '{print $1}'`
  port=`echo "$line" | awk -F : '{print $2}'`

  # 启动nmap，扫描一个网段
  nmap -n -sS -sV -T4 -p $port $ip --append-output -oG ./result/nmap.out.log > /dev/null &

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
    # 输出存活主机文件 格式 ip
    #awk '/^[^#]/{print $2}' ./result/nmap.out.log > ./result/ips.txt.$date
    #grep 'Status: Up' ./result/nmap.out.log | awk '/^[^#]/{print $2}' > ./result/ips.txt.$date
    # 删除临时文件
    mv ./result/nmap.out.log ./result/service.txt.$date
    echo 'finish..'
    break
  else
    sleep 3
  fi
done

echo ''
echo 'EndTime: ' `date`
