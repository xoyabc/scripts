#!/bin/bash
url_list="url.list"
cat ${url_list} |sed '/^\s*$/d' | while read url
do
    name=$(echo ${url} |awk '{print $1}')
    link=$(echo ${url} |awk '{print gensub(/https/,"http",1,$2)}')
    # the fllowing api is expired 03/11/2019
    #short_link=$(curl -s http://tools.aeink.com/tools/dwz/urldwz.php?longurl=${link} |jq -r '.[]')
    # https://fengmk2.com/blog/appkey.html
    short_link=$(curl -s "http://api.weibo.com/2/short_url/shorten.json?source=2849184197&url_long=${link}" |jq -r '.[]|.[]|.url_short')
    echo "[${name}]"
    echo ${short_link}
done 

