#!/bin/bash
# **********************************************************
# * Author        : xoyabc
# * Email         : xoyabc@qq.com
# * Last modified : 2019-05-29 10:02
# * Description   : 
# * ********************************************************

PORT=22
RESULT_FILE="/www/scripts/ip.txt"
IP_LIST="/www/scripts/ip.list"
> ${IP_LIST}
> ${RESULT_FILE}

IP=(
192.168.1.
192.168.2.
)

warn_echo(){
    echo -e "\033[40;93m$1 \033[0m"
}
info_echo(){
    echo -e "\033[40;32m$1 \033[0m"
}

#允许的进程数
THREAD_NUM=${1:-2000}
#定义描述符为9的管道
mkfifo tmp_fifo
exec 9<>tmp_fifo
#预先写入指定数量的换行符，一个换行符代表一个进程
for ((i=0;i<$THREAD_NUM;i++))
do
    echo -ne "\n" 1>&9
done

for ip_segment in ${IP[@]}
do
    for i in $(seq 1 1 253)
    do
        ip="${ip_segment}${i}"
        echo ${ip} >> ${IP_LIST}
    done
done

function check_port()
{
        host="$1"
        port="$2"
        nc -zv -w 2 ${host} ${port} &>/dev/null
        res=$?
        if [ ${res} -eq 0 ]
        then
                echo "up"
        else
                echo "down"
        fi
}


function check_ping()
{
        host="$1"
        ping -c 2 -i 0.1 ${host} -w 1 &>/dev/null
        res=$?
        if [ ${res} -eq 0 ]
        then
                echo "up"
        else
                echo "down"
        fi
}


date
while read ip
do
{
    #进程控制
    read -u 9
    {
            ping_result=$(check_ping ${ip})
            port_result=$(check_port ${ip} ${PORT})
        if [[ ${ping_result} == "up" && ${port_result} == "up" ]]
        then
                info_echo "${ip} ${ping_result} ${port_result}" >> ${RESULT_FILE}
        else
                warn_echo "${ip} ${ping_result} ${port_result}" >> ${RESULT_FILE}
        fi
        sleep 1
        echo -ne "\n" 1>&9
    }&
}
done < ${IP_LIST}
wait
echo "执行结束"
date
rm tmp_fifo
cat ${RESULT_FILE} |sort -k1 -o ${RESULT_FILE} 


#cat ip.list |while read ip
#do
#        ping_result=$(check_ping ${ip})
#        port_result=$(check_port ${ip} ${PORT})
#
#        if [[ ${ping_result} == "up" && ${port_result} == "up" ]]
#        then
#                info_echo "${ip} ${ping_result} ${port_result}" >> ${RESULT_FILE}
#        else
#                warn_echo "${ip} ${ping_result} ${port_result}" >> ${RESULT_FILE}
#        fi
#done
