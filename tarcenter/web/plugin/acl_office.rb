# encoding: utf-8

class Acl_office < WEBrick::HTTPServlet::AbstractServlet

  def do_GET req, res
    Base.header(req, res)

    path = File.dirname(__FILE__)
    # 获取日志目录中存在的日期数据,如果日志目录为空，直接退出
    dates = Util.filelist(path+'/../../acl_office/result/input.txt*')
    return '' if dates.size == 0
    # 参数中获取日期
    date = req.query['date']
    # 如果参数为空，默认为最新时间
    if date.nil? or date == ''
      date = dates.last
    end
    # 如果参数的日期，不存在日志目录中，直接退出
    return '' if !dates.include? date.to_i

    open_hosts = Util.readline(path+'/../../acl_office/result/ips.txt', date)
    open_ports = Util.readline(path+'/../../acl_office/result/ports.txt', date)
    open_prots = Util.readline(path+'/../../acl_office/result/prot.txt', date)
    targets    = Util.readline(path+'/../../acl_office/result/input.txt', date)

    shows = {}
    shows['对办公网开放主机'] = open_hosts
    shows['对办公网开放端口'] = open_ports
    shows['对办公网开放服务'] = open_prots
    shows['扫描目标网段'] = targets
    res.body += Util.linklist(dates, '/acl')
    res.body += Util.tabshow(shows)

    Base.footer(req, res)
  end

end

