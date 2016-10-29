require 'cgi'

class Util

  def self.readline(file,date,filter='')
    ret_str = ''
    file = file+'.'+date.to_s
    if !File.exists?(file) then
      ret_str = "file not exist."
    else
      File.open(file).each do |line|
        line = CGI.escapeHTML(line)
        if filter.length > 0
          ret_str += line+'<br/>' if line.strip.size > 0 and line.include?(filter)
        else
          ret_str += line+'<br/>' if line.strip.size > 0
        end
      end
    end
    ret_str
  end

  def self.filelist(file)
    dates = []
    Dir.glob(file).each do |ips|
      ary = ips.split('.txt.')
      dates << ary[1].to_i if ary[1]
    end
    dates.sort!
  end

  # 根据日期数据，生成链接
  def self.linklist(dates, url)
    text = 'DATE: '
    dates.each do |date|
      text += "<a href='#{url}?date=#{date}'>#{date}</a> |"
    end
    text
  end

  def self.tabshow(hash)
    body = ''
    body += '<ul class="nav nav-tabs" id="myTab"> '
    num = 0
    hash.each do |key,value|
      num += 1
      if num == 1
        body += "<li class=\"active\"><a href=\"#tab#{num}\" data-toggle=\"tab\">#{key}</a></li>"
      else
        body += "<li><a href=\"#tab#{num}\" data-toggle=\"tab\">#{key}</a></li>"
      end
    end
    body += '</ul> '
    body += '<div class="tab-content"> '
    num = 0
    hash.each do |key,value|
      num += 1
      if num == 1
        body += "<div class=\"tab-pane active\" id=\"tab#{num}\">#{value}</div>"
      else
        body += "<div class=\"tab-pane\" id=\"tab#{num}\">#{value}</div>"
      end
    end
    body += '</div> '
    body
  end

end
