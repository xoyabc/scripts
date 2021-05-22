#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
import csv
import codecs
import sys
reload(sys)
sys.setdefaultencoding("utf-8")

f1 = open('siff2020.csv', 'w')
f1.write(codecs.BOM_UTF8)


with open("json.txt", 'rU') as f:
    movie_info_list = []
    data = json.load(f)
    print type(data)

    with f1:
        # fieldnames must contain all fields in dict, or it will throw an exception:
        # " ValueError: dict contains fields not in fieldnames: u'show_time' "
        fnames = ['group', 'id', 'film1', 'film2', 'date', 'weekday', 'stime', 'etime', 'length', 'cinema', 'halls_name', 'director', 'country', 'co_production_country', 'resolving_power', 'projection_material', 'film_medium', 'show_type', 'memo', 'area', 'show_time']
        writer = csv.DictWriter(f1, fieldnames=fnames)
        writer.writeheader()
        #for i,v in enumerate(data[0:10]):
        for i,v in enumerate(data):
             writer.writerow(v)
