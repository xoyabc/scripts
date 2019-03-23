#!/bin/bash
# **********************************************************
# * Author        : xoyabc
# * Email         : xoyabc@qq.com
# * Last modified : 2018-12-13 15:26
# * Description   : 
# * ********************************************************

warn_echo(){
    echo -e "\033[40;93m$1 \033[0m"
}
info_echo(){
    echo -e "\033[40;32m$1 \033[0m"
}

PORT=22
RESULT_FILE="ip.txt"
> ip.list
> ${RESULT_FILE}

IP=(
192.168.1.
192.168.2.
)
for ip_segment in ${IP[@]}
do
    for i in $(seq 1 1 253)
    do
        ip="${ip_segment}${i}"
        echo ${ip} >> ip.list
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
        ping -c 2 -i 0.2 ${host} -w 1 &>/dev/null
        res=$?
        if [ ${res} -eq 0 ]
        then
                echo "up"
        else
                echo "down"
        fi
}


cat ip.list |while read ip
do
        ping_result=$(check_ping ${ip})
        port_result=$(check_port ${ip} ${PORT})

        if [[ ${ping_result} == "up" && ${port_result} == "up" ]]
        then
                info_echo "${ip} ${ping_result} ${port_result}" >> ${RESULT_FILE}
        else
                warn_echo "${ip} ${ping_result} ${port_result}" >> ${RESULT_FILE}
        fi
done
