class Base

  def self.header(req, res)
    Basic_auth.authenticate req, res
    res['Content-Type'] = 'text/html'
    res.body += Header
  end

  def self.footer(req, res)
    res.body += Footer
  end
  
  def self.email(title,text)
    smtp = { :address => 'smtp.126.com', 
             :port => 25, :domain => '126.com', 
             :user_name => 'ceshi', 
             :password => '123', 
             :enable_starttls_auto => true, 
             :openssl_verify_mode => 'none' }
    Mail.defaults { delivery_method :smtp, smtp }
    mail = Mail.new do
      from 'ceshi@126.com'
      to '123@qq.com'
      subject title
      body text
    end
    mail.deliver!
  end

end
