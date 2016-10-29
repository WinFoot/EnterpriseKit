#!/usr/bin/env ruby

require 'json'
require './lib/nessus_lib'

class NesReport

def initialize(debug=false)
  @vul_num = {critical: 0, high: 0, medium: 0, low: 0, info: 0}
  @result = {}
  @debug = debug
  @path = 'https://sec.com:8834'
  @user = 'root'
  @pass = ''
  @nessus = Nessus::Client.new @path, @user, @pass
  pp @nessus.get_server_properties if @debug
end

def vul_count(severity)
  case severity
  when 4
    @vul_num[:critical] += 1
  when 3
    @vul_num[:high] += 1
  when 2
    @vul_num[:medium] += 1
  when 1
    @vul_num[:low] += 1
  when 0
    @vul_num[:info] += 1
  else
    puts "error"
  end
end

#pp nessus.host_detail 369,26509
def vul_list(scan_id, host_id)
    ret = @nessus.host_detail(scan_id,host_id)
    ary = []
    ret['vulnerabilities'].each do |vul|
      plugin = {}
      hash = {}
      host_id   = vul['host_id']
      hostname  = vul['hostname']
      plugin_id = vul['plugin_id']
      severity  = vul['severity']
      vul_count(severity)
      hash['severity'] = vul['severity']
      hash['plugin_id'] = vul['plugin_id']
      hash['plugin_name'] = vul['plugin_name']
      hash['plugin_family'] = vul['plugin_family']
      hash['ips'] = []
      hash['ips'] << hostname
      puts hash if @debug
      plugin[plugin_id] = hash
      ary << plugin
    end
    ary
end

#pp n.scan_details 369
def host_list(scan_id)
  ret_ids = []
  scan_details = @nessus.scan_details(scan_id)
  hosts = scan_details['hosts']
  hosts.each do |host|
    host_id = host['host_id']
    hostname = host['hostname']
    puts "host_id:#{host_id} hostname:#{hostname}" if @debug
    ret_ids << host_id
  end
  ret_ids
end

#pp nessus.scan_list
def folder_list(folder_id=345)
  hosts = 0
  scan_list = @nessus.scan_list
  i = 0
  scan_list['scans'].each do |scan|
    next if scan['folder_id'] != folder_id
    i += 1
    scan_name = scan['name']
    scan_id   = scan['id']
    puts "#{i}: #{scan_id} #{scan_name}" if @debug

    host_ids = host_list(scan_id)
    hosts += host_ids.size
    puts "#{i}: #{scan_id} #{scan_name} #{host_ids.size}hosts" #if @debug

    host_ids.each do |host_id| 
      vul_ary = vul_list(scan_id, host_id)
      sort(vul_ary)
      puts "host_id:#{host_id} scan_id:#{scan_id}" if @debug
    end
    #break if i > 3

  end if scan_list['scans']
  return hosts
end

def scan_list(scan_id=63)
  hosts = 0
  scan_list = @nessus.scan_list
  host_ids = host_list(scan_id)
  hosts += host_ids.size
  host_ids.each do |host_id| 
    vul_ary = vul_list(scan_id, host_id)
    sort(vul_ary)
    puts "host_id:#{host_id} scan_id:#{scan_id}" if @debug
  end
  return hosts
end

def sort(vul_ary)
  vul_ary.each do |vul|
    vul.each do |key, value|
      plugin_id = key
      if @result.has_key? key
        @result[plugin_id]['ips'] << value['ips']
      else
        @result[plugin_id] = value
      end
    end
  end
end

def dump()
  puts "======== Start ========"
  puts "Report Time: " + Time.now.to_s
  #puts "======== Target ========"
  host_count = scan_list
  puts "======== VulsCount ========"
  puts @vul_num.to_s
  puts "host_count: #{host_count}"
  puts "======== Vulnerabilities ========"

  print = {}
  print['r4'] = []
  print['r3'] = []
  print['r2'] = []
  print['r1'] = []
  print['r0'] = []
  @result.each do |key, value|
    #puts item
    case value['severity']
    when 4
      print['r4'] << "Critical: #{value['plugin_name']} #{value['ips']}"
    when 3
      print['r3'] << "High: #{value['plugin_name']} #{value['ips']}"
    when 2
      print['r2'] << "Medium: #{value['plugin_name']} #{value['ips'].size}hosts"
    when 1
      print['r1'] << "Low: #{value['plugin_name']} #{value['ips'].size}hosts"
    when 0
      print['r0'] << "Info: #{value['plugin_name']} #{value['ips'].size}hosts"
    else
      puts "error"
    end
  end
  
  print.each do |key, value|
    value.each do |v|
      puts v
    end
  end

  puts "======== End ========"
end

def all_host(folder_id=345)
  scan_list = @nessus.scan_list
  i = 0
  scan_list['scans'].each do |scan|
    next if scan['folder_id'] != folder_id
    scan_name = scan['name']
    scan_id   = scan['id']
    puts "#{i}: #{scan_id} #{scan_name}" if @debug

    scan_details = @nessus.scan_details(scan_id)
    hosts = scan_details['hosts']
    hosts.each do |host|
      i += 1
      host_id = host['host_id']
      hostname = host['hostname']
      puts "#{i}: scan_id:#{scan_id} host_id:#{host_id} hostname:#{hostname}" #if @debug
    end
  end if scan_list['scans']

end

end

if $0 == __FILE__
  n = NesReport.new #true
  n.dump
  #n.all_host
end
