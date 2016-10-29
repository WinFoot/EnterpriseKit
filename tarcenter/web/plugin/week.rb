# encoding: utf-8

class Week < WEBrick::HTTPServlet::AbstractServlet

  def do_GET req, res
    Base.header(req, res)

    path = File.dirname(__FILE__)
    # 获取日志目录中存在的日期数据,如果日志目录为空，直接退出
    dates = Util.filelist(path+'/../../weekpass/result/input.txt*')
    return '' if dates.size == 0
    # 参数中获取日期
    date = req.query['date']
    # 如果参数为空，默认为最新时间
    if date.nil? or date == ''
      date = dates.last
    end
    # 如果参数的日期，不存在日志目录中，直接退出
    return '' if !dates.include? date.to_i

    weekp_ports = Util.readline(path+'/../../weekpass/result/medusa.txt', date, 'ACCOUNT FOUND')
    login_ports = Util.readline(path+'/../../weekpass/result/masscan.txt', date)
    targets     = Util.readline(path+'/../../weekpass/result/input.txt', date)

    shows = {}
    shows['弱口令主机端口'] = weekp_ports 
    shows['可登陆主机端口'] = login_ports 
    shows['扫描目标网段'] = targets
    res.body += Util.linklist(dates, '/week')
    res.body += Util.tabshow(shows)

    Base.footer(req, res)
  end

end

