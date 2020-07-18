#!/usr/bin/env python
# -*- coding: utf-8 -*-
# env: python 2.7
import json
import csv
import codecs
import sys
reload(sys)
sys.setdefaultencoding("utf-8")

f_csv = open('siff2019_info.csv', 'w')
f_csv.write(codecs.BOM_UTF8)

with open("json.txt", 'rU') as f:
    movie_info_list = []
    base_info = []
    data = json.load(f)
    print type(data)
    for i,v in enumerate(data[0:10]):
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
        # 介质
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
            halls_name = 'N/A'
        show_time = movie_dict['show_time']
        print group,id,name_cn,name_en,date,weekday,stime,etime,length,cinema,halls_name, \
              show_type,director,country,co_production_country,resolving_power,film_medium
        base_info = [group,id,name_cn,name_en,date,weekday,stime,etime,length,cinema,halls_name,show_type,director,country,co_production_country,resolving_power,film_medium]
        movie_info_list.append(base_info)

    with f_csv:
        writer = csv.writer(f_csv)
        for row in movie_info_list:
            writer.writerow(row)
