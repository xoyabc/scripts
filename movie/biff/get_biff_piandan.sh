#!/bin/bash

# 输入 JSON 文件
#INPUT_FILE="data.json"
OUTPUT_FILE="output.csv"

> movie.csv

# 处理 JSON 并转换为 CSV
echo "Code,DateEn,Time,Title,Venue,hallNm,saleStatus,remainSeat" > ${OUTPUT_FILE}  # 添加 CSV 表头


for date in $(seq -w 07 1 15)
do
	curl -s "https://filmapi.maketicket.co.kr/api/v1/prodList?chnlCd=WEB&perfDate=2026-10-${date}&venueSeq=&langCd=en&partnerId=BIFF" |jq -r '.prodList[] |[.sdCode, .sdDateEn, .sdTime, .perfMainNm, .venueNm, .hallNm, .saleStatus, .remainSeat] | @csv' >> ${OUTPUT_FILE}
done

#/usr/bin/iconv -f utf-8 -t GBK ${OUTPUT_FILE} -o movie.csv
/usr/bin/iconv -f utf-8 -t gb18030 ${OUTPUT_FILE} -o movie.csv
echo "转换完成，CSV 保存为 movie.csv"
