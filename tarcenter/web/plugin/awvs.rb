# encoding: utf-8

class Awvs < WEBrick::HTTPServlet::AbstractServlet


  def do_GET req, res
    Base.header(req, res)

    path = File.dirname(__FILE__)
    # 获取日志目录中存在的日期数据,如果日志目录为空，直接退出
    dates = Util.filelist(path+'/../../awvs/result/input.txt*')
    return '' if dates.size == 0
    # 参数中获取日期
    date = req.query['date']
    # 如果参数为空，默认为最新时间
    if date.nil? or date == ''
      date = dates.last
    end
    # 如果参数的日期，不存在日志目录中，直接退出
    return '' if !dates.include? date.to_i

    report = Util.readline(path+'/../../awvs/result/awvs.txt', date)
    target = Util.readline(path+'/../../awvs/result/input.txt', date)

    shows = {}
    shows['WEB漏洞报告详情'] = report
    shows['WEB扫描目标详情'] = target
    res.body += Util.linklist(dates, '/awvs')
    res.body += Util.tabshow(shows)

    Base.footer(req, res)
  end

end

