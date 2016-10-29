# encoding: utf-8
require 'webrick'

config = { :Realm => 'BasicAuth example realm' }
htpasswd = WEBrick::HTTPAuth::Htpasswd.new File.dirname(__FILE__)+'/auth_file'
htpasswd.set_passwd config[:Realm], 'damifan', 'fanqiedan'
htpasswd.flush
config[:UserDB] = htpasswd
Basic_auth = WEBrick::HTTPAuth::BasicAuth.new config
