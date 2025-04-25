#!/bin/bash

> result_date
> result_time
> time_and_day

dos2unix time
cat time |while read line;do date -d @${line}  +"%Y/%m/%d %H:%M" |awk '{print $1}' >> result_date;done 
cat time |while read line;do date -d @${line}  +"%Y/%m/%d %H:%M" |awk '{print $2}' >> result_time;done 
cat time |while read line;do date -d @${line}  +"%Y/%m/%d %H:%M" >> time_and_day ;done 
