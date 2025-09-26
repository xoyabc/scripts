#!/bin/bash
# 临时设置环境变量为UTF-8
export LANG=zh_CN.UTF-8

# 输入 JSON 文件
#INPUT_FILE="data.json"
OUTPUT_FILE="output.csv"

> movie.csv

# 处理 JSON 并转换为 CSV
echo "id,date,startTime,endTime,price,activityCinemaName,activityCinemaHall,hasTickets" > ${OUTPUT_FILE}  # 添加 CSV 表头


# id_lists
# main_id id chn_name
for id in $(cat id_lists |awk '{print $1}')
do
	curl -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36' -s "https://api.pyiffestival.com/app/api/v1/ActivityFilm/${id}" |jq -r '.activityFilmPlans|.[] | [.id, .date, .startTime, .endTime, .price, .activityCinemaName, .activityCinemaHall, .hasTickets] | @csv' >> ${OUTPUT_FILE}
done

#/usr/bin/iconv -f utf-8 -t GBK ${OUTPUT_FILE} -o movie.csv
/usr/bin/iconv -f utf-8 -t gb18030 ${OUTPUT_FILE} -o movie.csv
echo "转换完成，CSV 保存为 movie.csv"

# vow
mail_addr_1=1031138448@qq.com
for id in 08ddf7d7-dac4-4ffc-868d-6c3335588bc2 08ddf7e1-5dac-4007-8f4a-1bde1cd0b92a 08ddf7dd-aa63-43c0-8bcf-626eb8ded4fa 08ddf7e1-0ef8-411a-8984-0c146b30d332 08ddf7e1-a94c-4185-82fe-c0b6adcf178b 08ddf7dd-f711-42d0-857e-078570ac8761 08ddf7d8-9841-4985-860c-0f627a0d9d44 08ddf7e1-db01-41b8-884a-fbd6409f576b 08ddf7de-2006-4063-8a0d-cf83942c4bb6 08ddf7d8-6c2c-4ac3-8868-db3df3413872 08ddf7ce-1f26-4a7d-8a56-c089d7591522 08ddf7d5-c590-4d2d-87a1-fa9ed516d2fb 08ddf7df-78f5-4d84-8c96-1f67fc969905 08ddf7e0-c140-4b6f-85e9-31c3ab700e34 08ddf7dc-ae0b-42f9-8c1e-6f07891dc2d3
do
        if [ $(cat movie.csv |awk -v value=${id} -F "," '$1 ~ value{print $NF}' |grep true |wc -l) -ge 1 ]
        then
		time=$(cat movie.csv |grep -a ${id} |awk -F "," '{print $3}' |sed 's#"##g')
		title=$(cat id_lists |grep ${id} |awk '{print $3}')
                echo "${title} ${time}" | mail -s "${time} ${title}" ${mail_addr_1} &>/dev/null 
        fi
done

# 泥巴
mail_addr_2=nzj1299@qq.com
for id in 08ddf83b-4e4a-4a98-8e48-73ac0cae348c
do
        if [ $(cat movie.csv |awk -v value=${id} -F "," '$1 ~ value{print $NF}' |grep true |wc -l) -ge 1 ]
        then
		time=$(cat movie.csv |grep -a ${id} |awk -F "," '{print $3}' |sed 's#"##g')
		title=$(cat id_lists |grep ${id} |awk '{print $3}')
                echo "${title} ${time}" | mail -s "${time} ${title}" ${mail_addr_2} &>/dev/null 
        fi

done

# Y.Y.J
mail_addr_3=543816423@qq.com
for id in 08ddf83b-4e4a-4a98-8e48-73ac0cae348c
do
        if [ $(cat movie.csv |awk -v value=${id} -F "," '$1 ~ value{print $NF}' |grep true |wc -l) -ge 1 ]
        then
		time=$(cat movie.csv |grep -a ${id} |awk -F "," '{print $3}' |sed 's#"##g')
		title=$(cat id_lists |grep ${id} |awk '{print $3}')
                echo "${title} ${time}" | mail -s "${time} ${title}" ${mail_addr_3} &>/dev/null 
        fi
done

# 1kfm5
mail_addr_4=its1kfm5@163.com
for id in 08ddf83b-4e4a-4a98-8e48-73ac0cae348c
do
        if [ $(cat movie.csv |awk -v value=${id} -F "," '$1 ~ value{print $NF}' |grep true |wc -l) -ge 1 ]
        then
		time=$(cat movie.csv |grep -a ${id} |awk -F "," '{print $3}' |sed 's#"##g')
		title=$(cat id_lists |grep ${id} |awk '{print $3}')
                echo "${title} ${time}" | mail -s "${time} ${title}" ${mail_addr_4} &>/dev/null 
        fi
done
