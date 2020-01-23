#!/usr/bin/python
# coding=UTF-8
from mytools import HttpRequest
import json
import re
import sys
import logging

def match_rule(value):
    #print(type(text))
    #print(value)
    #value = json.dumps(text)
    if "男" in value:
        return True
    ret = re.match(r"^\"1[35678]\d{9}", value)
    if ret:
        return True
    ret = re.match(r"^\d{15}|\d{18}$", value)
    if ret:
        return True
    return False

def get_solr_dbs( http ):
    ary = []
    txt = http.mkurl(path='solr/admin/cores?wt=json').text()
    text = json.loads(txt)
    dbs = text['status']
    for db in dbs:
        numDocs = dbs[db]['index']['numDocs']
        if  numDocs > 100:
            #print(db+' numDocs: '+str(numDocs))
            ary.append(db)
    return ary

def select_solr_data( http , dbnames):
    for dbname in dbnames:
        txt = http.mkurl(path="solr/"+dbname+"/select?indent=on&q=*:*&wt=json").text()
        text = json.loads(txt)
        docs = text['response']['docs']
        for doc in docs:
            for k,v in doc.items():
                value = json.dumps(v)
                if match_rule(value):
                    logging.error("Sensitive solr: %s db: %s value: %s" % (http.addr,dbname,value))

def find_solr_app( http ):
    txt = http.mkurl(path='solr/').text()
    if txt.find('<html ng-app="solrAdminApp">') == -1 :
        logging.info('No solr: ' + http.addr)
        exit(0)
    else:
        logging.error('Found solr: ' + http.addr)

if __name__ == "__main__":
    logging.basicConfig(level=logging.WARNING,filename='sens.log')
    # 初始化
    #domain = '139.59.56.119'
    domain = sys.argv[1]

    # 1.检查是否为SolrAdminApp服务
    http = HttpRequest(domain,port='80')
    find_solr_app(http)
    # 2.获取solr数据库列表
    dbnames = get_solr_dbs(http)
    logging.error('Found solr: %s dbnames: %s' % (http.addr, str(dbnames)))
    # 3.发现存在敏感数据的位置
    select_solr_data(http, dbnames)
