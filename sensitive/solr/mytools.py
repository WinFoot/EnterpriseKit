# coding=UTF-8
import requests
import logging

#完成HTTP请求
class HttpRequest: 
	#HttpRequest(url,param).http_request(method,cookies)
	def __init__(self,domain,scheme='http',port='80',path='',param=None):
		self.scheme = scheme
		self.domain = domain
		self.port   = port
		self.path   = path
		self.param  = param
		self.url    = "%s://%s:%s/%s" % (self.scheme, self.domain, self.port, self.path)
		self.addr    = "%s://%s:%s/" % (self.scheme, self.domain, self.port)

	def mkurl(self,domain=None,scheme=None,port=None,path=None):
		if domain:
			self.domain = domain
		if scheme:
			self.scheme = scheme
		if port:
			self.port   = port
		if path:
			self.path   = path
		self.url    = "%s://%s:%s/%s" % (self.scheme, self.domain, self.port, self.path)
		self.addr    = "%s://%s:%s/" % (self.scheme, self.domain, self.port)
		return self

	def request(self,method='GET',cookies=None,timeout=(3,3)):#定义了默认值
		try:
			if method.upper()=='GET':
				res=requests.get(self.url,self.param,cookies=cookies,timeout=timeout)
			elif method.upper()=='POST':
				res=requests.post(self.url,self.param,cookies=cookies,timeout=timeout)
			else:
				logging.info("错误的请求方式")
			return res
		except Exception, e:
			logging.info(e)

	def text(self):
		response = self.request()
		if response:
			return response.text
		return ""
