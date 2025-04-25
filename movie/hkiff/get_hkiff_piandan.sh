#!/bin/bash

# 输入 JSON 文件
#INPUT_FILE="data.json"
OUTPUT_FILE="output.csv"

> movie.csv

# 处理 JSON 并转换为 CSV
echo "nameEn,nameTc,nameSc,performanceTime,duration,filmEventTypeId,stockLabel,facilityNameTc" > ${OUTPUT_FILE}  # 添加 CSV 表头

for file in $(seq 1 1 17)
do
	cat ${file} |jq -r '.data[]|.performances|.[] | [.nameEn, .nameTc, .nameSc, .performanceTime, .duration, .filmEventTypeId, .stockLabel, .facilityNameTc] | @csv' >> ${OUTPUT_FILE}
done

#/usr/bin/iconv -f utf-8 -t GBK ${OUTPUT_FILE} -o movie.csv
/usr/bin/iconv -f utf-8 -t gb18030 ${OUTPUT_FILE} -o movie.csv
echo "转换完成，CSV 保存为 movie.csv"
