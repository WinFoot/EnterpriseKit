# encoding: utf-8

Header = '''<html>
<head>
<meta charset="utf-8"/>
<title>数据统计系统</title> <link href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
<script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
</head>
<body>

<nav class="navbar navbar-inverse">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="/">内网安全-数据统计系统</a>
    </div>
    <div id="navbar" class="collapse navbar-collapse">
      <ul class="nav navbar-nav">
        <li class="active.bk"><a href="/acl">ACL</a></li>
        <li><a href="/acl_office">AclOff</a></li>
        <li><a href="/week">Week</a></li>
        <li><a href="/ids">IDS</a></li>
        <li><a href="/nessus">Nessus</a></li>
        <li><a href="/awvs">AWVS</a></li>
        <li><a href="/alert">Alert</a></li>
      </ul>
    </div><!--/.nav-collapse -->
  </div>
</nav>

<div class="container">
<div class="row">
<div class="col-md-12">
<!--h3><a href="/">-= Masport=-</a> <small>Web</small></h3-->
<!--a onclick="window.history.go(-1);">&lt;&lt;Back </a> | -->
<!--a href="/task"> Task List</a> | <a href="/add"> Task Add</a><br /><br /-->
'''

Footer = '''
</div>
</div>
</div>
</body>
</html>
'''

Index =  '''
<h4>安全防护功能</h4>
<ul>
<li> 对互联网开放的主机、端口和服务</li>
<li> 对办公网开放的主机、端口和服务</li>
<li> ACL策略审核</li>
<li> ACL策略检测：合法、非法、过期</li>
</ul><br/>

<h4>安全扫描功能</h4>
<ul>
<li> 可登陆服务、弱口令扫描</li>
<li> 脆弱服务、未授权访问 redis rsync mongo</li>
<li> Nessus 高危漏洞 中危漏洞 扫描与修补</li>
<li> Awvs 高危漏洞 中危漏洞 扫描与修补</li>
</ul><br/>

<h4>安全监控功能</h4>
<ul>
<li> IDS 办公网流量监测</li>
<li> IDC 部署蜜罐</li>
</ul><br/>

<h4>周期任务执行</h4>
<ul>
<li> AWVS 高危漏洞 中危漏洞</li>
<li> Nessus 存活主机 高危漏洞 中危漏洞</li>
<li> IDS-HTTP 来源-目的-域名-URL</li>
<li> ACL互联网开放全端口扫描</li>
<li> IDS 报警统计分析</li>
<li> 每周弱口令扫描报表</li>
</ul><br/>

<h4>密码服务</h4>
<p>
CVS, FTP, HTTP, IMAP, MS-SQL, MySQL, NNTP, VNC<br>
PcAnywhere, POP3, PostgreSQL, REXEC, RLOGIN,<br> 
RSH, SMBNT, SMTP-AUTH, SMTP-VRFY, SNMP, SSHv2,<br> 
Subversion (SVN), Telnet, VMware Authentication Daemon (vmauthd)<br>
</p><br/>

<h4>报警邮件API</h4>
<p>
curl --data "title=title&text=text" http://127.0.0.1:9000/alert</br>
Alert log<br/>
curl --data "log=log" http://127.0.0.1:9000/alert</br>
</p><br/>


'''

Add =  '''
<h2>New Task</h2>
<form action="/task" method="post">
<input type="submit" value="Add Task >>"><br />
<textarea  rows="8" cols="48" name="ipaddr"></textarea><br />
<b>Port : </b><br />
<input name="port" value="80,81,8080,8081,8090" ><br /><br />
<b>Description : </b><br />
<input name="desc" ><br /><br />

<b>Example IP: </b><br />
192.168.0.1<br/>
10.0.0.0/8<br/>
10.0.0.1-10.0.0.254<br/>
<b>Example PORT: </b><br />
80<br/>
80,8080<br/>
1-65535<br/>
</form><br />
'''

