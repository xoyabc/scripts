#!/bin/bash

OUTPUT_FILE="output.csv"

# pageNo=1&pageSize=1000
# curl 'https://www.uutix.com/api/oversea/projectGroup/hkiffpb2026/getProjectGroupDataList?t=1773158837987&WuKongReady=h5&projectGroupId=13&pageNo=1&pageSize=1000'

jq -r '
  ["projectName", "projectStartTime", "venueName"],
  (.data[].projectList[] | [.projectName, .projectStartTime, .venueName])
  | @csv
' /tmp/1 > ${OUTPUT_FILE}

/usr/bin/iconv -f utf-8 -t gb18030 ${OUTPUT_FILE} -o movie.csv
echo "转换完成，CSV 保存为 movie.csv"
