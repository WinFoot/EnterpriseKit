#!/usr/bin/env ruby

require 'json'
require 'date'
require 'mail'
require 'cgi'

# Crontab:
# 0 */6 * * * /root/Porject/develop/tarcenter/alert/es_alert.rb
#
def get_alert(time_pre,time_now)
  `curl --user admin:pass http://172.200.100.38:9200/ids-*/_search -d '{ 
    "query": {
      "filtered": {
        "query": {
          "query_string": {
            "query": "*",
            "analyze_wildcard": true
          }
        },
        "filter": {
          "bool": {
            "must": [
              {
                "query": {
                  "query_string": {
                    "analyze_wildcard": true,
                    "query": "*"
                  }
                }
              },
              {
                "range": {
                  "@timestamp": {
                    "gte": #{time_pre},
                    "lte": #{time_now}
                  }
                }
              }
            ],
            "must_not": []
          }
        }
      }
    },
    "size": 0,
    "aggs": {
      "2": {
        "terms": {
          "field": "alert.signature.raw",
          "size": 10,
          "order": {
            "_count": "desc"
          }
        }
      }
    }
  }' 2> /dev/null
  `
end

def email(title,text)
  smtp = { :address => 'smtp.126.com', 
           :port => 25, :domain => '126.com', 
           :user_name => 'ceshi', 
           :password => '123', 
           :enable_starttls_auto => true, 
           :openssl_verify_mode => 'none' }
  Mail.defaults { delivery_method :smtp, smtp }
  mail = Mail.new do
    from 'ceshi@126.com'
    to '123456@qq.com'
    subject title
    body text
  end
  mail.deliver!
end


time_now = Time.now.to_datetime.strftime('%Q').to_i
time_pre = time_now - 6 * 3600 * 1000
from = "#{DateTime.strptime(time_pre.to_s, '%Q').strftime('%F %H:%m')}"
to   = "#{DateTime.strptime(time_now.to_s, '%Q').strftime('%F %H:%m')}"

alert = {}
data = get_alert(time_pre,time_now)
p data
json = JSON.parse data
data = json['aggregations']
data.each do |key,value|
  alert['from']    = from
  alert['to']      = to
  alert['alerts']  = value['buckets']
  if alert['alerts'].size > 0
    title = "IDS Alert - #{Time.now}"
    text = "[#{from} to #{to}] \n"
    alert["alerts"].each do |alt|
      text += "#{alt['key']} => #{alt['doc_count']} \n"
    end
    email(title, text)
    #title = CGI::escape title
    #text  = CGI::escape text
    #cmd = "curl --data \"title=#{title}&text=#{text}\" http://127.0.0.1:9000/alert"
    #puts cmd
    #result = `#{cmd}`
    #puts result
    
  end
  time = Time.new.strftime("%Y%m%d")
  path = File.dirname(__FILE__)
  output = path + '/result/alert.txt.'+time
  File.open(output, 'a') { |file| 
    file.write(alert.to_s+"\n") 
  }
end if data

