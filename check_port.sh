#!/bin/bash
# **********************************************************
# * Author        : xoyabc
# * Email         : 1031138448@qq.com
# * Last modified : 2018-07-03 15:26
# * Filename      : check_port.sh
# * Description   : 
# * ********************************************************

warn_echo(){
    echo -e "\033[40;93m[Warning]: $1 \033[0m"
}
info_echo(){
    echo -e "\033[40;32m[Info]: $1 \033[0m"
}


function check_port()
{
        host="$1"
        port="$2"
        nc -zv -w 2 ${host} ${port} &>/dev/null
        res=$?
        if [ ${res} -eq 0 ]
        then
                echo "ok"
        else
                echo "bad"
        fi
}


function check_ping()
{
        host="$1"
        ping -c 2 -i 0.2 ${host} -w 1 &>/dev/null
        res=$?
        if [ ${res} -eq 0 ]
        then
                echo "ok"
        else
                echo "bad"
        fi
}


cat ip.list |while read ip
do
        ping_result=$(check_ping ${ip})
        port_result=$(check_port ${ip} 22)

        if [[ ${ping_result} == "ok" && ${port_result} == "ok" ]]
        then
                info_echo "${ip} ${ping_result} ${port_result}"
        else
                warn_echo "${ip} ${ping_result} ${port_result}"
        fi
done
