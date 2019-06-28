#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
import csv
import codecs
import sys
reload(sys)
sys.setdefaultencoding("utf-8")


with open("json.txt", 'rU') as f:
    movie_info_list = []
    data = json.load(f)
    print type(data)
    f1 = open('siff2019.csv', 'w')
    f1.write(codecs.BOM_UTF8)
    with f1:
        fnames = ['group', 'area', 'halls_name', 'country', 'cinema', 'projection_material', 'etime', 'director', 'show_time', 'length', 'film_medium', 'weekday', 'date', 'film2', 'film1', 'show_type', 'resolving_power', 'id', 'co_production_country', 'stime']
        writer = csv.DictWriter(f1, fieldnames=fnames)
        writer.writeheader()
        #for i,v in enumerate(data[0:10]):
        for i,v in enumerate(data):
             writer.writerow(v)
