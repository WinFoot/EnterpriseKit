# encoding: utf-8

class Acl < WEBrick::HTTPServlet::AbstractServlet

  def do_GET req, res
    Base.header(req, res)

    path = File.dirname(__FILE__)
    # 获取日志目录中存在的日期数据,如果日志目录为空，直接退出
    dates = Util.filelist(path+'/../../acl/result/input.txt*')
    return '' if dates.size == 0
    # 参数中获取日期
    date = req.query['date']
    # 如果参数为空，默认为最新时间
    if date.nil? or date == ''
      date = dates.last
    end
    # 如果参数的日期，不存在日志目录中，直接退出
    return '' if !dates.include? date.to_i

    open_hosts = Util.readline(path+'/../../acl/result/ips.txt', date)
    open_ports = Util.readline(path+'/../../acl/result/ports.txt', date)
    open_servs = Util.readline(path+'/../../acl/result/service.txt', date,'Ports')
    targets    = Util.readline(path+'/../../acl/result/input.txt', date)

    shows = {}
    shows['对外开放主机列表'] = open_hosts
    shows['对外开放端口列表'] = open_ports
    shows['对外开放服务列表'] = open_servs
    shows['扫描目标网段'] = targets
    res.body += Util.linklist(dates, '/acl')
    res.body += Util.tabshow(shows)

    Base.footer(req, res)
  end

end

