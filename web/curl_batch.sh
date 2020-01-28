#!/bin/sh
#
# 功能说明：
# 批量执行curl,检测页面中存在某个特征(页面包含Tomcat),输出检测结果
#
# 使用说明：
#
# 输入需要检测的域名
# echo 'www.baidu.com' >> ./domain.list
# echo 'tomcat.apache.org' >> ./domain.list
#
# 输出结果：
# www.baidu.com =No=
# tomcat.apache.org =Yes=
#

while read line
do
  echo -n "$line "
  curl --connect-timeout 2 -m 3 -sk "http://$line:80/index.html" | grep ' Tomcat' > /dev/null

  if [ $? -eq 0 ]; then
    echo "=Yes="
  else
    echo "=No="
  fi
done < ./domain.list
