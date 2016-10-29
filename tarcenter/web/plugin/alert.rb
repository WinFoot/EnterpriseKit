# encoding: utf-8

class Alert < WEBrick::HTTPServlet::AbstractServlet

  def do_GET req, res
    Base.header(req, res)

    path = File.dirname(__FILE__)
    # 获取日志目录中存在的日期数据,如果日志目录为空，直接退出
    dates = Util.filelist(path+'/../../alert/result/alert.txt*')
    return '' if dates.size == 0
    # 参数中获取日期
    date = req.query['date']
    # 如果参数为空，默认为最新时间
    if date.nil? or date == ''
      date = dates.last
    end
    # 如果参数的日期，不存在日志目录中，直接退出
    return '' if !dates.include? date.to_i

    alert = Util.readline(path+'/../../alert/result/alert.txt', date)

    shows = {}
    shows['报警日志'] = alert
    res.body += Util.linklist(dates, '/alert')
    res.body += Util.tabshow(shows)

    Base.footer(req, res)
  end

  def do_POST req, res 
 
    #title = CGI::escape title
    #text  = CGI::escape text
    #cmd = "curl --data \"title=#{title}&text=#{text}\" http://127.0.0.1:9000/alert"
    #puts cmd
    #result = `#{cmd}`
    #puts result

    title = req.query['title']
    text  = req.query['text']
    log   = req.query['log']

    if title
      Base.email(title, text)
    end

    if log  
      time = Time.new.strftime("%Y%m%d")
      path = File.dirname(__FILE__)
      output = path + '/../../alert/result/alert.txt.'+time
      File.open(output,'a') {|file| file.write(title+' '+text+" \n")}
    end

  end

end

