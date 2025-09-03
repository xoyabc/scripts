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

def get_movie_url():
    for day in xrange(18, 26):
    #for day in xrange(18, 19):
        url_link = 'https://www.biff.kr/eng/html/schedule/date.asp?day1={0}' .format(day)
        #url_link = 'https://www.biff.kr/eng/html/schedule/date.asp?day1=19'
        # request douban
        r = requests.get(url_link, headers=douban_headers)
        # store the html data to soup
        soup = BeautifulSoup(r.text.encode('utf-8'), 'lxml')
        for i in soup.select('div[class="film_tit"]'):
            try:
                url = 'https://www.biff.kr' + i.a['href']
                if not url in url_list:
                    url_list.append(url)
            except:
                pass
    return url_list


def get_movie_base_info(url_link):
    #url_link = 'https://www.biff.kr/eng/html/program/prog_view.asp?idx=80666&c_idx=419&sp_idx=&QueryStep=2'
    # request douban
    r = requests.get(url_link, headers=douban_headers)
    # store the html data to soup
    soup = BeautifulSoup(r.text.encode('utf-8'), 'lxml')
    try:
        Section = soup.select('div[class="breadcrumb"]')[0].span.text
    except:
        Section = 'N/A'
    try:
        mv_title = soup.select('span[class="h2 tit_h1"]')[0].text.rstrip()
    except:
        mv_title = 'N/A'

    # keywords
    try:
        keywords_list = [i.text.strip() for i in soup.select('div[class="film_tit"]')[0].find_all('div', attrs={"class": "keywords"}) ]
        keywords = ", " .join(keywords_list)
    except:
        keywords = 'N/A'

    try:
        Country_anchor = soup.find("span", text=re.compile("Country"))
        Country = Country_anchor.next_element.next_element.strip()
    except:
        Country = 'N/A'

    try:
        Production_Year_anchor = soup.find("span", text=re.compile("Production Year"))
        Production_Year = Production_Year_anchor.next_element.next_element.strip()
    except:
        Production_Year = 'N/A'

    try:
        Running_Time_anchor = soup.find("span", text=re.compile("Running Time"))
        Running_Time = Running_Time_anchor.next_element.next_element.strip().replace('min', '')
    except:
        Running_Time = 'N/A'

    try:
        Format_anchor = soup.find("span", text=re.compile("Format"))
        Format = Format_anchor.next_element.next_element.strip()
    except:
        Format = 'N/A'

    try:
        Color_anchor = soup.find("span", text=re.compile("Color"))
        Color = Color_anchor.next_element.next_element.strip()
    except:
        Color = 'N/A'

    for s in soup.find_all('div', attrs={"class": "pgv_sch_li"}):
        try:
            code_anchor = s.find("span", text=re.compile("code"))
            code = code_anchor.next_element.next_element.strip()
        except:
            code = 'N/A'
        try:
            date_anchor = s.find("span", text=re.compile("date"))
            date = date_anchor.next_element.next_element.strip()
        except:
            date = 'N/A'
        try:
            time_anchor = s.find("span", text=re.compile("time"))
            time = time_anchor.next_element.next_element.strip()
        except:
            time = 'N/A'
        try:
            theater_anchor = s.find("span", text=re.compile("theater"))
            theater = theater_anchor.next_element.next_element.strip()
        except:
            theater = 'N/A'
        try:
            pattern = re.compile(r'^ico_grade ico_(g|12|15|19)$')
            Ratings = list(s.find_all('div', class_=pattern)[0].stripped_strings)[0]
        except:
            Ratings = 'N/A'
        try:
            Subtitle = s.find(attrs={'class' : 'ico_grade ico_ke'}).text
        except:
            Subtitle = 'Unmarked'
        try:
            Information = s.find(attrs={'class' : 'ico_grade ico_gv'}).text
        except:
            Information = 'N/A'
        try:
            Director_list = [ x.text.rstrip() for x in soup.find_all('strong', attrs={"class": "dir_name desc bold"}) ]
            Director = " / " .join(Director_list)
        except:
            Director = 'N/A'
        movie_infos = "{0}\t{1}\t{2}\t{3}\t{4}\t{5}\t{6}\t{7}\t{8}\t{9}\t{10}\t{11}\t{12}\t{13}\t{14}" \
                             .format(code,Section,mv_title,date,time,Running_Time,theater,
                                     Ratings,Subtitle,Information,Director,Country,
                                     Production_Year,Format,Color)
        movie_info_list.append(movie_infos)
        print code,date,time,theater,Running_Time,Ratings,Subtitle,Information,Director


def get_schedule_detailed_info():
    url_lists = get_movie_url()
    for url_link in url_lists:
        get_movie_base_info(url_link)
    return movie_info_list


if __name__ == '__main__':
    movie_info = {}
    movie_info_list = []
    url_list = []
    get_movie_url()
    f_csv = 'movie.csv'
    head_instruction = "code\tSection\tmv_title\tdate\ttime\tRunning_Time\ttheater\tRatings\tSubtitle\tInformation\tDirector\tCountry\tProduction_Year\tFormat\tColor"
    movie_info_list = get_schedule_detailed_info()
    #movie_info_list = get_movie_base_info()
    write_to_csv(f_csv, head_instruction, *movie_info_list)
