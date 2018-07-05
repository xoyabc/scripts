#!/usr/bin/env python
# -*- coding: utf-8 -*-
# **********************************************************
# * Author        : louxiaohui
# * Email         : xiaohui.lou@quanshi.com
# * Last modified : 2018-07-03 23:11
# * Filename      : host.py
# * Description   : 
# * ********************************************************
import json
import sys
reload(sys)
sys.setdefaultencoding("utf-8")
from lxml import etree

info_list = []

def load_json_from_file(f):
    data = json.load(f)
    data_list = data['Data']
    return data_list

def get_element_of_span_or_code(text):
    html = etree.HTML(text)
    result = html.xpath('//td//code|//span')[0].text
    if result is not None:
        result = result.replace(',', '')
    else:
        result = "None"
    return result

def get_element_of_td(text):
    html = etree.HTML(text)
    try:
        result = html.xpath('//td')[0].text
    except AttributeError:
        #print "{0} AttributeError" .format(text)
        result = text
    return result    

def line_prepender(filename, line):
    with open(filename, 'r+') as f:
        content = f.read()
        f.seek(0, 0)
        f.write(line.rstrip('\r\n') + '\n' + content)

def write_vm_info_to_file(f):
    data_list = load_json_from_file(f)
    for machine in data_list:
        # get the value of the machine dict
        host = machine['host_on']
        lan_ip = machine['management_ip']
        service = machine['service']
        hostname = machine['hostname']
        asset_type = machine['asset_type']
        ram = machine['ram']
        cpu_core_count = machine['cpu_core_count']
        disk = machine['disk']
        # get the real value of every item
        r_hostname = get_element_of_span_or_code(hostname) 
        r_lan_ip = get_element_of_span_or_code(lan_ip)
        r_service = get_element_of_span_or_code(service)
        r_ram = get_element_of_td(ram)
        r_cpu_core_count = get_element_of_td(cpu_core_count)
        r_disk = get_element_of_td(disk)
        r_host = get_element_of_td(host)
        r_vm_info = '{0} {1} {2} {3} {4} {5} {6}\n' .format(r_hostname,r_lan_ip,r_service,r_ram,r_cpu_core_count,r_disk,r_host)
        info_list.append(r_vm_info)
        print r_vm_info
    # write to result file
    with open ('result', 'w')  as f:
        f.writelines(info_list)

if __name__=='__main__':
    f = open("test.json")
    head_instruction = "主机名 内网IP 服务 内存(M) CPU核数 硬盘(G) 宿主机IP"
    write_vm_info_to_file(f)   
    line_prepender('result', head_instruction)
