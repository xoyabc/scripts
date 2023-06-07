#!/bin/bash
# **********************************************************
# * Author        : xoyabc
# * Email         : 1031138448@qq.com
# * Last modified : 2019-04-09 22:26
# * Filename      : check_port.sh
# * Description   : 
# * ********************************************************

#!/bin/bash
# **********************************************************
# * Author        : louxiaohui
# * Email         : xiaohui.lou@quanshi.com
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

PORT=${1:-22}


which nc &>/dev/null
[ $? -ne 0 ] && wget -qO /etc/yum.repos.d/JD-Base.repo   http://116.198.48.75/conf/JD-Base.repo && yum makeca
che && yum -y install nc &>/dev/null

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

printf "%15s %11s %5s\n" "IP" "Ping" "Port"   

cat ip.list |sed '/^\s*$/d' |while read ip
do
        ping_result=$(check_ping ${ip})
        port_result=$(check_port ${ip} ${PORT})
        if [[ ${ping_result} == "ok" && ${port_result} == "ok" ]]
        then
                info_echo "${ip}    ${ping_result}    ${port_result}"
        else
                warn_echo "${ip}    ${ping_result}    ${port_result}"
        fi
done
