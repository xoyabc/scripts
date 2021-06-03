#!/usr/bin/env python2
# -*- coding: utf-8 -*-
import json
import csv
import codecs
import sys
reload(sys)
sys.setdefaultencoding("utf-8")

f_csv = open('siff2021_info.csv', 'w')
f_csv.write(codecs.BOM_UTF8)

with open("json.txt", 'rU') as f:
    movie_info_list = []
    base_info = []
    data = json.load(f)
    data.sort(key=lambda x: (x.get("group","N/A"),x.get("name_cn","N/A"),x.get("date","N/A"),x.get("cinema","N/A")), reverse=False) 
    print type(data)
    #for i,v in enumerate(data[0:10]):
    for i,v in enumerate(data):
        movie_dict = v
        id = movie_dict['id']
        group = movie_dict['group']
        name_cn = movie_dict['nameCn']
        name_en = movie_dict['nameEn']
        length = movie_dict.get('length', 'N/A')
        country = movie_dict['country']
        director = movie_dict['director']
        date = movie_dict['date']
        weekday = movie_dict['weekday']
        stime = movie_dict['stime']
        etime = movie_dict['etime']
        cinema = movie_dict['cinema']
        show_type = movie_dict['showType']
        show_type = '见面场' if '2' in show_type else '普通场'
        # 分辨率
        try:
            resolution = 'N/A' if movie_dict['resolution'] == '' or movie_dict['resolution'] == None else movie_dict.get('resolution', 'N/A')
        except Exception as e:
            resolution = 'N/A'
        # 色彩
        try:
            color = 'N/A' if movie_dict['color'] == '' or movie_dict['color'] == None else movie_dict.get('color', 'N/A')
        except Exception as e:
            color = 'N/A'
        # 影厅
        try:
            hallsName = 'N/A' if movie_dict['hallsName'] == '' or movie_dict['hallsName'] == None else movie_dict.get('hallsName', 'N/A')
        except Exception as e:
            hallsName = 'N/A'
        # 备注
        try:
            remarks = 'N/A' if movie_dict['remarks'] == '' or movie_dict['remarks'] == None else movie_dict.get('remarks', 'N/A')
        except Exception as e:
            remarks = 'N/A'
        #print group,id,name_cn,name_en,date,weekday,stime,etime,length,cinema,hallsName, \
        #      director,country,resolution,color,show_type,remarks
        base_info = [group,id,name_cn,name_en,date,weekday,stime,etime,length,cinema,hallsName,director,country,resolution,color,show_type,remarks]
        movie_info_list.append(base_info)

    head_line_eng = "group\tid\tname_cn\tname_en\tdate\tweekday\tstime\tetime\tlength\tcinema\thallsName\tdirector\tcountry\tresolution\tcolor\tshow_type\tremarks"
    head_line_cn = "单元\t影片id\t中文名\t英文名\t日期\t星期几\t开始时间\t结束时间\t片长\t影院\t影厅\t导演\t制片国家/地区\t分辨率\t色彩\t场次类型\t备注"
    with f_csv:
        writer = csv.writer(f_csv)
        writer.writerow(head_line_eng.split('\t'))
        writer.writerow(head_line_cn.split('\t'))
        for row in movie_info_list:
            writer.writerow(row)
