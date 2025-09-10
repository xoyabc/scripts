#!/bin/bash

# 输入 JSON 文件
#INPUT_FILE="data.json"
OUTPUT_FILE="output.csv"

> film.csv

# 处理 JSON 并转换为 CSV
echo "Code,prodSeq,sdSeq,DateEn,Time,Title,Venue,hallNm,saleStatus,remainSeat" > ${OUTPUT_FILE}  # 添加 CSV 表头


#for date in $(seq 20 1 20)
for date in $(seq 17 1 26)
do
	curl -s "https://filmapi.maketicket.co.kr/api/v1/prodList?chnlCd=WEB&perfDate=2025-09-${date}&venueSeq=&langCd=en" |jq -r '.prodList[] |[.sdCode, .prodSeq, .sdSeq, .sdDateEn, .sdTime, .perfMainNm, .venueNm, .hallNm, .saleStatus, .remainSeat] | @csv' >> ${OUTPUT_FILE}
done

#/usr/bin/iconv -f utf-8 -t GBK ${OUTPUT_FILE} -o film.csv
/usr/bin/iconv -f utf-8 -t gb18030 ${OUTPUT_FILE} -o film.csv
#echo "转换完成，CSV 保存为 film.csv"

# CCJ
#mail_addr=1031138448@qq.com
mail_addr=995715054@qq.com
for CCJ_code in 167 179
do
	if [ $(cat film.csv |awk -v value=${CCJ_code} -F "," '$1 ~ value{print $NF}' |grep -E '[1-9][0-9]*' |wc -l) -ge 1 ]
	then
		echo "Code ${CCJ_code}" | mail -s "BIFF Code ${CCJ_code}" ${mail_addr} 1031138448@qq.com &>/dev/null 
	fi
done

# 1kfm5
mail_addr_2=its1kfm5@163.com
for CCJ_code in 402 493 535 577
do
	if [ $(cat film.csv |awk -v value=${CCJ_code} -F "," '$1 ~ value{print $NF}' |grep -E '[1-9][0-9]*' |wc -l) -ge 1 ]
	then
		echo "Code ${CCJ_code}" | mail -s "BIFF Code ${CCJ_code}" ${mail_addr_2} &>/dev/null 
	fi
done

# ping
mail_addr_3=yyp_1999@foxmail.com
for CCJ_code in 241
do
	if [ $(cat film.csv |awk -v value=${CCJ_code} -F "," '$1 ~ value{print $NF}' |grep -E '[1-9][0-9]*' |wc -l) -ge 1 ]
	then
		echo "Code ${CCJ_code}" | mail -s "BIFF Code ${CCJ_code}" ${mail_addr_3} 1031138448@qq.com &>/dev/null 
	fi
done
