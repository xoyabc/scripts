#!/bin/bash

> seat.csv

echo "totVisitorCnt,visitorCnt" >> seat.csv
# notice : token ends up with '%3D'
token="eGyKOwsJmrKvhrhPKGVtUaw5QiY7saeFQXdQnnzuKiCel0i7YBvUCWB7tsP4lQRZupF6RIbG6xHevnomwtwdoA%3D%3D%3Aq%2F0BlHAl0WvGjXiTL5mGrcWBg%2F85j8IfZGnwqaBQNUI%3D"

cat seat.txt |while read line
do 
	prodSeq=$(echo ${line} |awk '{print $1}')
	sdSeq=$(echo ${line} |awk '{print $2}')
	echo ${prodSeq} ${sdSeq}

	curl -s 'https://filmonestopapi.maketicket.co.kr/api/v1/rs/seatStateInfo' \
	  -H 'Accept: application/json, text/javascript, */*; q=0.01' \
	  -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8' \
	  -H 'Connection: keep-alive' \
	  -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
	  -b '_ga=GA1.1.1028351698.1756804348; _ga_Q9RFXH57MN=GS2.1.s1756804347$o1$g1$t1756804533$j60$l0$h0; wmp_pcstamp=1756976905643920223; SCOUTER=x47ia9kq3tppun; langCd=en; setFilmTicket=ABfGFOAz6W6Qa3PuAqVKziC8%2BHJpMdkTbOPrHqblRF4202jlYgPx8WP7GrBsGAKO5Tki4PGqHx0iQXtIe%2Ba16Cb1SlhStrT0NgjzTDc5oYZpHDImH8vzeg565qPOHfSlhStrT79jpYSlhStrTbyPAqAe97tmOoWyJvBt10bQ%3D%3D; _ga_DKVGW12YFX=GS2.1.s1757338477$o9$g1$t1757338538$j60$l0$h0' \
	  -H 'DNT: 1' \
	  -H 'Origin: https://filmonestop.maketicket.co.kr' \
	  -H 'Referer: https://filmonestop.maketicket.co.kr/' \
	  -H 'Sec-Fetch-Dest: empty' \
	  -H 'Sec-Fetch-Mode: cors' \
	  -H 'Sec-Fetch-Site: same-site' \
	  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36' \
	  -H 'sec-ch-ua: "Not;A=Brand";v="99", "Google Chrome";v="139", "Chromium";v="139"' \
	  -H 'sec-ch-ua-mobile: ?0' \
	  -H 'sec-ch-ua-platform: "Windows"' \
	  --data-raw "prodSeq=${prodSeq}&sdSeq=${sdSeq}&seatId=1&csrfToken=${token}" | jq -r '[.totVisitorCnt, .visitorCnt] | @csv' >> seat.csv
	echo -e '\n'
done
