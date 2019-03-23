#!/usr/bin/env python
# coding=utf-8
import re 
import sys
import random
import datetime
reload(sys)
sys.setdefaultencoding("utf-8")

file = '/scripts/conf/motto.txt'
file_new = '/data/wwwroot/ys.louxiaohui.com/template/paody/aaaa/right.js'
line_num = len(open(file,'rU').readlines())

def write_to_log(filepath, content):
    with open(filepath, 'w') as f:
        js_content = 'document.writeln("{0}");' .format(content)
        print js_content
        f.write(js_content)

def update_motto():
    with open('/scripts/conf/motto.txt','rU') as f:
        random_index = random.randrange(0, line_num)
        for i, v in enumerate(f):
            if i == random_index:
                motto = v.strip()
                print motto
                write_to_log(file_new, motto)

if __name__ == '__main__':
    print datetime.datetime.now().strftime("%F %T")
    update_motto()
