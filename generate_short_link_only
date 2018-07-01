``` bash
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

echo $1
link=$(rawurlencode "$1")
echo $link
short_link=$(curl -s http://tools.aeink.com/tools/dwz/urldwz.php?longurl="${link}" |jq -r '.[]')
echo ${short_link}
#curl -s --data-urlencode "url=https://pan.baidu.com/share/link?shareid=2150752008&uk=3658720284&fid=1098510934183426" "http://tool.chinaz.com/AjaxSeo.aspx?t=sinadwz" |jq -r '.[]|.url_short' 
```
