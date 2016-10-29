#!/usr/bin/env ruby
# encoding: utf-8

require 'webrick'
require 'json'
require 'mail'
require "digest/md5"
require_relative './plugin/ids'
require_relative './plugin/acl'
require_relative './plugin/acl_office'
require_relative './plugin/awvs'
require_relative './plugin/week'
require_relative './plugin/nessus'
require_relative './plugin/alert'
require_relative './lib/auth'
require_relative './lib/str'
require_relative './lib/util'
require_relative './lib/base'

#log_file = File.open '/tmp/webrick.log', 'a'
#log = WEBrick::Log.new log_file

server=WEBrick::HTTPServer.new :Port => 9000#, :Logger=>log#, :AccessLog=>access_log

# Keyborad Int
#trap 'QUIT' do server.shutdown end 

# Index Page
server.mount_proc "/" do |req, res|
	Basic_auth.authenticate req, res
	res['Content-Type'] = 'text/html'
	res.body += Header
	res.body += Index	
	res.body += Footer
end

server.mount_proc "/add" do |req, res|
	Basic_auth.authenticate req, res
	res['Content-Type'] = 'text/html'
	res.body += Header
	res.body += Add
	res.body += Footer
end

# Task Show
server.mount '/ids', Ids
server.mount '/acl', Acl
server.mount '/acl_office', Acl_office
server.mount '/awvs', Awvs
server.mount '/week', Week
server.mount '/nessus', Nessus
server.mount '/alert', Alert

#WEBrick::Utils.su 'nobody'
WEBrick::Daemon.start
server.start

