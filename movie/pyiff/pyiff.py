#!/usr/bin/env python
# -*- coding: utf-8 -*-
import re  
import sys  
import urllib  
import requests
import random
import json
import csv
import codecs
from bs4 import BeautifulSoup  
from urllib import unquote
from decimal import Decimal
import time
reload(sys)
sys.setdefaultencoding("utf-8")


# write to csv file
def write_to_csv(filename, head_line, *info_list):
    with open(filename, 'w') as f:
        f.write(codecs.BOM_UTF8)
        writer = csv.writer(f)
        writer.writerow(head_line.split('\t'))
        for row in info_list:
            row_list = row.split('\t')
            writer.writerow(row_list)

# header content
douban_headers = {
     'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.81 Safari/537.36',
     'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
     'Accept-Encoding': 'gzip, deflate, sdch',
     'Accept-Language': 'zh-CN,zh;q=0.8,en-US;q=0.6,en;q=0.4,en-GB;q=0.2,zh-TW;q=0.2',
     'Connection': 'keep-alive',
     'DNT': '1'
}


def _to_timestamp(dt):
    timeArray = time.strptime(dt, "%Y-%m-%d %H:%M:%S")
    ts = time.mktime(timeArray)
    return ts


def _to_dt(ts):
    timeArray = time.localtime(ts)
    dt = time.strftime("%H:%M", timeArray)
    return dt


def get_movie_url():
    # 全部影片 ActivityFilmCategoryId=08dc52b9-dbe8-4013-8174-36da2b836233
    all_mv_url = 'https://api.pyiffestival.com/app/api/v1/Activity/86922480-1965-45c1-9440-d25c8d2ff7dc/ActivityFilms?ActivityFilmCategoryId=08dc52b9-dbe8-4013-8174-36da2b836233&Language=0&pageIndex=1&pageSize=60&SearchText='
    # request douban
    res = requests.get(all_mv_url, headers=douban_headers, verify=False)
    json_data=res.json()['items']
    for i in json_data:
        url = 'https://api.pyiffestival.com/app/api/v1/ActivityFilm/' + i['id']
        if not url in url_list:
            url_list.append(url)
    print url_list
    return url_list


def get_schedule_base_info(url_link):
    #url_link = 'https://api.pyiffestival.com/app/api/v1/ActivityFilm/08ddf65e-a99c-4a4e-844e-2443a4c04d71'
    # request douban
    res = requests.get(url_link, headers=douban_headers, verify=False)
    json_data=res.json()
    activityFilmCategoryName = json_data['activityFilmCategoryName']
    activityFilmName = json_data['activityFilmName']
    basicInformation = json_data['basicInformation']
    if len(json_data['activityFilmPlans']) > 0:
        for info in json_data['activityFilmPlans']:
            id = info['id']
            date = info['date'].split()[0]
            startTime = ":" .join(info['startTime'].split()[1].split(':')[0:2])
            endTime = ":" .join(info['endTime'].split()[1].split(':')[0:2])
            price = int(info['price'])
            activityCinemaName = info['activityCinemaName']
            activityCinemaHall = info['activityCinemaHall']
            hasTickets = info['hasTickets']
            movie_infos = "{0}\t{1}\t{2}\t{3}\t{4}\t{5}\t{6}\t{7}\t{8}\t{9}\t{10}" \
                                 .format(id,activityFilmCategoryName,activityFilmName,
                                         basicInformation,date,startTime,endTime,price,
                                         activityCinemaName,activityCinemaHall,hasTickets)
            movie_info_list.append(movie_infos)
            print id,activityFilmCategoryName,activityFilmName,basicInformation,date,startTime,endTime,price,activityCinemaName,activityCinemaHall,hasTickets


def get_schedule_detailed_info():
    url_lists = get_movie_url()
    for url_link in url_lists:
        get_schedule_base_info(url_link)
    return movie_info_list


if __name__ == '__main__':
    movie_info = {}
    movie_info_list = []
    url_list = []
    f_csv = 'movie.csv'
    head_instruction = "id\tactivityFilmCategoryName\tactivityFilmName\tbasicInformation\tdate\tstartTime\tendTime\tprice\tactivityCinemaName\tactivityCinemaHall,hasTickets"
    movie_info_list = get_schedule_detailed_info()
    #movie_info_list = get_schedule_base_info()
    write_to_csv(f_csv, head_instruction, *movie_info_list)
