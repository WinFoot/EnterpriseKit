#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json

class Website():

    def __init__(self):
        self.plug = {}
        self.info = {}
        self.tags = []
        self.keys = ['Cookies', 'HTTPServer', 'Title', 'IP', 
                'Country', 'PasswordField', 'Email']

    def to_tags(self):
        return self.tags

    def to_dict(self):
        return self.info

    def to_td(self, var):
        if var.startswith('http://') or var.startswith('https://'):
            return '<td title="' + var + '"> <a target="_blank" href="' +var+ '"> ' + var[:20] + '</a> </td>'
        else:
            return '<td title="' + var + '">' + var[:20] + '</td>'

    def to_td2(self, var):
        return '<td title="' + var + '">' + var + '</td>'

    def to_tr(self):
        tr = '<tr>'
        tr += self.to_td(self.info['target'])
        tr += self.to_td(str(self.info['http_status']))
        tr += self.to_td(self.info['Title'])
        tr += self.to_td(self.info['IP'])
        tr += self.to_td(self.info['HTTPServer'])
        tr += self.to_td(self.info['Country'])
        tr += self.to_td(self.info['PasswordField'])
        tr += self.to_td(self.info['Cookies'])
        tr += self.to_td(self.info['Email'])
        tr += self.to_td2(' '.join(self.tags))
        tr += '</tr>'
        return tr

    def to_sort(self):
        return self.plug

    def sort(self, plg):
        dict = plg['plugins']
        for k in dict.keys():
            if k not in self.keys:
                if self.plug.has_key(k):
                    self.plug[k] += " "+plg['target']
                else:
                    self.plug[k] = plg['target']

    def parse(self, dict):
        self.dict = dict
        self.parse_dict()
        self.parse_tags()

    def parse_tags(self):
        dict = self.dict['plugins']
        for k in dict.keys():
            if k not in self.keys:
                if dict[k]:
                    self.tags.append(k+':'+self.plugin_value(dict[k]))
                else:
                    self.tags.append(k)

    def parse_dict(self):
        self.info['target'] = self.dict['target']
        self.info['http_status'] = self.dict['http_status']
        dict = self.dict['plugins']
        for k in self.keys:
            self.info[k] = ''
            if dict.has_key(k):
                if dict[k]:
                    self.info[k] = self.plugin_value(dict[k])

    def plugin_value(self, pv):
        value = ''
        if pv.has_key('string'):
            value += ''.join(pv['string'])
        elif pv.has_key('version'):
            value += ''.join(pv['version'])
        elif pv.has_key('module'):
            value += ''.join(pv['module'])
        else:
            value += str(pv)
        return value


def logJson():
    log = '''{"target":"http://touchtt.abc.com","http_status":200,"plugins":{"Cookies":{"string":["JSESSIONID"]},"Country":{"string":["CHINA"],"module":["CN"]},"HTML5":{},"HTTPServer":{"string":["yy"]},"IP":{"string":["13.13.20.13"]},"Java":{},"Title":{"string":["abc网"]}}}'''
    return json.loads(log) 

if __name__ == '__main__':
    data = logJson()
    ws = Website()
    ws.parse(data)
    ws.sort(data)
    print(ws.to_dict())
    print(ws.to_tags())
    print(ws.to_tr())
    print(ws.to_sort())
