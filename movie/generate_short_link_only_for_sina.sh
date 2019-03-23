#!/bin/bash

rawurlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"    # You can either set a return variable (FASTER) 
  REPLY="${encoded}"   #+or echo the result (EASIER)... or both... :p
}
url=$(echo "$1" |sed 's#https#http#g')
#echo ${url}
link=$(rawurlencode "${url}")
#echo ${link}
# the fllowing api is expired 03/11/2019
#short_link=$(curl -s http://tools.aeink.com/tools/dwz/urldwz.php?longurl=${link} |jq -r '.[]')
# https://fengmk2.com/blog/appkey.html
short_link=$(curl -s "http://api.weibo.com/2/short_url/shorten.json?source=2849184197&url_long=${link}" |jq -r '.[]|.[]|.url_short')
#short_link=$(tiny "$1")
echo ${short_link}
