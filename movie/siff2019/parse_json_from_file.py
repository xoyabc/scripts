#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
import csv
import codecs
import sys
reload(sys)
sys.setdefaultencoding("utf-8")

f_csv = open('siff2020_info.csv', 'w')
f_csv.write(codecs.BOM_UTF8)

with open("json.txt", 'rU') as f:
    movie_info_list = []
    base_info = []
    data = json.load(f)
    print type(data)
    #for i,v in enumerate(data[0:10]):
    for i,v in enumerate(data):
        movie_dict = v
        id = movie_dict['id']
        group = movie_dict['group']
        name_cn = movie_dict['film1']
        name_en = movie_dict['film2']
        length = movie_dict.get('length', 'N/A')
        country = movie_dict['country']
        director = movie_dict['director']
        date = movie_dict['date']
        weekday = movie_dict['weekday']
        stime = movie_dict['stime']
        etime = movie_dict['etime']
        cinema = movie_dict['cinema']
        show_type = movie_dict['show_type']
        show_type = '见面场' if '2' in show_type else '普通场'
        # 分辨率
        try:
            resolving_power = 'N/A' if movie_dict['resolving_power'] == '' or movie_dict['resolving_power'] == None else movie_dict.get('resolving_power', 'N/A')
        except Exception as e:
            resolving_power = 'N/A'
        # 特殊介质
        try:
            projection_material = 'N/A' if movie_dict['projection_material'] == '' or movie_dict['projection_material'] == None else movie_dict.get('projection_material', 'N/A')
        except Exception as e:
            projection_material = 'N/A'
        # 色彩
        try:
            film_medium = 'N/A' if movie_dict['film_medium'] == '' or movie_dict['film_medium'] == None else movie_dict.get('film_medium', 'N/A')
        except Exception as e:
            film_medium = 'N/A'
        #film_medium = movie_dict['film_medium']
        #halls_name = movie_dict['halls_name']
        # 影厅
        try:
            halls_name = 'N/A' if movie_dict['halls_name'] == '' or movie_dict['halls_name'] == None else movie_dict.get('halls_name', 'N/A')
        except Exception as e:
            halls_name = 'N/A'
        # 合拍国
        try:
            co_production_country = 'N/A' if movie_dict['co_production_country'] == '' or movie_dict['co_production_country'] == None else movie_dict.get('co_production_country', 'N/A')
        except Exception as e:
            co_production_country = 'N/A'
        show_time = movie_dict['show_time']
        # 备注
        try:
            memo = 'N/A' if movie_dict['memo'] == '' or movie_dict['memo'] == None else movie_dict.get('memo', 'N/A')
        except Exception as e:
            memo = 'N/A'
        print group,id,name_cn,name_en,date,weekday,stime,etime,length,cinema,halls_name, \
              director,country,co_production_country,resolving_power,projection_material,film_medium,show_type,memo
        base_info = [group,id,name_cn,name_en,date,weekday,stime,etime,length,cinema,halls_name,director,country,co_production_country,resolving_power,projection_material,film_medium,show_type,memo]
        movie_info_list.append(base_info)

    head_line_eng = "group\tid\tfilm1\tfilm2\tdate\tweekday\tstime\tetime\tlength\tcinema\thalls_name\tdirector\tcountry\tco_production_country\tresolving_power\tprojection_material\tfilm_medium\tshow_type\tmemo"
    head_line_cn = "单元\t影片id\t中文名\t英文名\t日期\t星期几\t开始时间\t结束时间\t片长\t影院\t影厅\t导演\t制片国家/地区\t合拍国\t分辨率\t特殊介质\t色彩\t场次类型\t备注"
    with f_csv:
        writer = csv.writer(f_csv)
        writer.writerow(head_line_eng.split('\t'))
        writer.writerow(head_line_cn.split('\t'))
        for row in movie_info_list:
            writer.writerow(row)
