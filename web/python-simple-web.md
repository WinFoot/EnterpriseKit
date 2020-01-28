---
layout: kpost
title:  "Py建立最简web服务器"
categories: 常用工具
---

# 用Python建立最简单的web服务器
```
$ python -m SimpleHTTPServer 8080
```

# 支持开发功能的 基础web
```python
from BaseHTTPServer import HTTPServer, BaseHTTPRequestHandler

class TestHTTPHandle(BaseHTTPRequestHandler):
	def do_GET(self):
		buf = '''
		      <html>
		          <head><title>Not Found</title> </head>
		          <body> The requested document '%s' was not found.  </body>
		      </html>
		      '''
		self.protocal_version = "HTTP/1.1"
		self.send_response(200)
		self.send_header("Welcome", "Contect")
		self.end_headers()
		self.wfile.write(buf)

def start_server():
	http_server = HTTPServer(('0.0.0.0', 8080), TestHTTPHandle)
	http_server.serve_forever()

start_server()
```
