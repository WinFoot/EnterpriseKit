#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
import logging
from lib.website import Website

def readJSON(inputJsonFile):
    f = file(inputJsonFile)
    arr = []
    for eachLine in f:
        line = eachLine.strip().decode('utf-8')
        data = json.loads(line) 
        arr.append(data)
        logging.debug(data)
    f.close

def toHTML(table):
    html = '<html><head><meta http-equiv="content-type" content="text/html;charset=utf-8"></head>'
    html += '<table border-spacing="0" border="1">\n<tr>'
    html += '<tr><th>Target</th><th>Status</th><th>Title</th><th>IP</th><th>Server</th>'
    html += '<th>Country</th><th>Password</th><th>Cookies</th><th>Email</th><th>Tags</th></tr>'
    html += table
    html += "\n</table></html>"
    return html

def run(filename):
    f = file(filename)
    table = ''
    for eachLine in f:
        line = eachLine.strip().decode('utf-8')
        data = json.loads(line) 
        ws = Website()
        ws.parse(data)
        table += ws.to_tr()
        logging.debug(ws.dict)
    f.close

    html = toHTML(table)
    print(html)

if __name__ == '__main__':
    run('./output.log')

