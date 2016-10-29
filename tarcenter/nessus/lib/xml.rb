# 直接读取nessus xml报告
require 'nokogiri'

def parse(doc)
doc.xpath('//ReportHost').each do |item|
  #puts item['name']
  item.xpath('ReportItem').each do |node|
    if node['severity'].to_i == 3
    puts "#{item['name']}  #{node['svc_name']}/#{node['port']} #{node['severity']} #{node['pluginName']}"
    end
  end
end
end

Dir[File.dirname(__FILE__)+"/report/*.nessus"].each do |file|
  f = File.open(file)
  doc = Nokogiri::XML(f)
  parse(doc)
  f.close
end

