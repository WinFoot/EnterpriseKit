---
layout: kpost
title:  "http代理 https反向代理"
categories: 常用工具
---

# ApacheHTTPS反向代理加认证

```
vim /etc/httpd/conf.d/ssl.conf

<VirtualHost _default_:443>

  ProxyPass / http://127.0.0.1:5601/
  ProxyPassReverse / http://127.0.0.1:5601/

  <Location />
  AuthName "Basic Auth Dir"
  AuthType Basic
  AuthUserFile /etc/httpd/basic_auth.db
  require valid-user
  </Location>

</VirtualHost>

htpasswd -c  /etc/httpd/basic_auth.db username
loguser
logpwd
```

# Linux_http代理

```
export http_porxy=yourproxy.com:port
export https_proxy=yourproxy.com:port

export http_proxy=http://domain\\user:pwd@proxy_addr:port   
export https_proxy= http://domain\\user:pwd@proxy_addr:port 
export ftp_proxy= http://domain\\user:pwd@proxy_addr:port     
export no_proxy=proxy_addr:port

```

