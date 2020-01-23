# EnterpriseKit

  工作中整理的企业安全工具箱，方便有同样需求的你，持续更新啦！

## 目录

### tarcenter
- 集成acl监控、awvs监控、ids监控、nessus监控、weekpass监控、alert报警，web展示的统计分析系统

### elk_syslog 
- 使用elk解析和收集系统日志，包含syslog日志，secure日志，bash日志，和启动脚本

### nessus_report 
- nessus扫描多个任务，需要统计为一份报告，先创建一个扫描文件夹，把任务添加进去，使用统计脚本，配置好文件夹的id，就可以批量统计多个扫描的数据，自带nessus-ruby-api库

### mobile
- 移动安全评估工具

### wordlist
- 简单字典库

### 3rd_audit
- 第三方软件系统检查工具

### nmap_multi 
- 对于企业级的网络一个nmap进程实在是太慢了，服务器占有很小，浪费了我大服务器!纯bash实现多进程nmap，将多个网段写入input.txt，在脚本中配置namp参数和并发数，机器多强并发多快，请自己斟酌。开始扫描，体验大网段65535扫描的新速度

### sensitive
- 敏感信息探测，检测对外开放的服务是否存在未授权访问，并且数据中包含敏感信息

### Sys

- sys/filemon.sh **系统安全角度使用这个脚本，监控web目录，是否被上传了webshell，并发送邮件及时告知**
- sys/rpm_changelog.sh **系统漏洞补丁检查，检测CVE补丁是否已经生效**
- sys/gdb_demo.md **测试学习GDB的小例子**
- sys/make_demo.md **测试学习Make的小例子**
- sys/qemu_demo.md **测试学习Qemu的小例子**
- sys/kali_tools.txt **整理Kali工具清单**
- sys/read_elf.c **遍历ELF**

### Web

- web/curl_batch.sh  **批量执行curl，检测页面中存在某个特征，输出检测结果**
- web/python-simple-web.md **Py建立最简web服务器**
- web/http-https-proxy.md **http代理 https反向代理**
- find_web/ **多进程探活爬取多个C段下的网站信息，统计词频**