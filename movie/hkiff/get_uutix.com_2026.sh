#!/bin/bash

# pageNo=1&pageSize=1000
# curl 'https://www.uutix.com/api/oversea/projectGroup/hkiffpb2026/getProjectGroupDataList?t=1773158837987&WuKongReady=h5&projectGroupId=13&pageNo=1&pageSize=1000'

jq -r '
  ["projectName", "projectStartTime", "venueName"],
  (.data[].projectList[] | [.projectName, .projectStartTime, .venueName])
  | @csv
' /tmp/1 > output.csv
