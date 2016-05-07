#!/usr/bin/env python
# -*- coding: utf-8 -*-

from lib.bottle import get, post, request, route, run, template
import json
from lib.website import Website

filename='./output.log'

@get('/')
def index():
    index = '''
        <html> <body>
        Function: <a href="/list"> List </a>
        <a href='/sort'> Sort </a>
        <form method="POST" action="/scan">
          <input type="text" name="targets" />
          <input type="submit" />
        </form>
        </body> </html>
    '''
    return index

@get('/list')
def list():
    f = file(filename)
    table = ''
    ws = Website()
    for eachLine in f:
        line = eachLine.strip().decode('utf-8')
        data = json.loads(line) 
        ws.parse(data)
        table += ws.to_tr()
    f.close
    html = '<html><head><meta http-equiv="content-type" content="text/html;charset=utf-8"></head>'
    html += '<table border-spacing="0" border="1">\n<tr>'
    html += '<tr><th>Target</th><th>Status</th><th>Title</th><th>IP</th><th>Server</th>'
    html += '<th>Country</th><th>Password</th><th>Cookies</th><th>Email</th><th>Tags</th></tr>'
    html += table
    html += "\n</table></html>"
    return html

@get('/sort')
def sort():
    f = file(filename)
    ws = Website()
    for eachLine in f:
        line = eachLine.strip().decode('utf-8')
        data = json.loads(line) 
        ws.sort(data)
    f.close

    html = '<html><head><meta http-equiv="content-type" content="text/html;charset=utf-8"></head>'
    html += '<table border-spacing="0" border="1">\n<tr>'
    html += '<tr><th>Tags</th><th>Target</th></tr>'

    data = ws.to_sort()
    for i in data:
        html += '<tr><td>'+i+'</td><td>'+ data[i] +'</td></tr>'

    html += "\n</table></html>"
    return html


@post('/scan') 
def scan():
    targets = request.forms.get('targets')
    return targets

run(host='0.0.0.0', port=5000)
