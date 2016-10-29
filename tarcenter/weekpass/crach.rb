#!/usr/bin/env ruby

time = Time.new.strftime("%Y%m%d")
puts "StartTime: #{Time.now}"

# Found the opened ports.
input='./input.txt'
output='./result/masscan.out.tmp.'+time
#ports='21,22,23,25,110,119,143,161,445,465,512,513,514,902,1433,2401,3306,3389,3690,5432,5631,5900'
ports='21,22,23,110,119,143,161,445,512,513,514,902,1433,2401,3306,3389,5432,5631'
cmd = "masscan -p #{ports} --rate 10000 -iL #{input} -oG #{output} && cp #{input} ./result/#{input}.#{time}"
puts 'Running syscmd: ' + cmd
`#{cmd}`

# Output the result as 'ip:port' format.
input='./result/masscan.out.tmp.'+time
output='./result/masscan.txt.'+time
cmd="awk -F '[ |/]' '/^[^#]/{print $2\":\"$4}' #{input} > #{output} && rm -rf #{input}"
puts 'Running syscmd: ' + cmd
`#{cmd}`

input='./result/masscan.txt.'+time
output = './result/medusa.txt.'+time
dict_user = './dict/user.txt'
dict_pass = './dict/pass.txt'
File.open(input).each do |line|
  ary  = line.chomp!.split ':'
  ip   = ary[0]
  port = ary[1]
  service = {}
  service['21']='ftp'
  service['22']='ssh'
  service['23']='telnet'
  service['25']='smtp-vrfy'
  service['110']='pop3'
  service['119']='nntp'
  service['143']='imap'
  service['161']='snmp'
  service['445']='smbnt'
  service['465']='smtp'
  service['512']='rexec'
  service['513']='rlogin'
  service['514']='rsh'
  service['902']='vmauthd'
  service['1433']='mssql'
  service['2401']='cvs'
  service['3306']='mysql'
  service['3389']='rdp'
  service['3690']='svn'
  service['5432']='postgres'
  service['5631']='pcanywhere'
  service['5900']='vnc'

  cmd = "nohup medusa -f -e ns -t 64 -w 1 -v 4 -M #{service[port]} -h #{ip} -n #{port} -U #{dict_user} -P #{dict_pass} -O #{output} > /tmp/weekpass.log &"
  #cmd = "medusa -f -e ns -t 64 -w 1 -v 4 -M #{service[port]} -h #{ip} -n #{port} -U #{dict_user} -P #{dict_pass} -O #{output}"
  puts 'Running syscmd: ' + cmd
  `#{cmd}`

end

puts "EndTime: #{Time.now}"
