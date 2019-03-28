#!/bin/bash
# **********************************************************
# * Author        : xoyabc
# * Email         : lxh1031138448@gmail.com
# * Last modified : 2019-03-28 23:24
# * Filename      : array.sh
# * Description   : more than one element
# **********************************************************
# REF:
# https://www.jianshu.com/p/543fa9df3469
# https://blog.csdn.net/ee230/article/details/48316317 
ip_array=(
200 ZR
201 ZR
202 ZR
203 ZR
)

len=${#ip_array[@]}
echo "len is $len"

for((i=0;i<len;i+=2))
do
        echo $i
        ip=${ip_array[i]}
        role=${ip_array[i+1]}
        echo "${ip_array[i]} , ${ip_array[i+1]}"
        echo "ip is $ip, role is $role"
done

# two-dimensional array 
declare -a TEST
TEST=(
'1 2'
'3 4'
'5 6'
)
for i in "${TEST[@]}"
do  
    b=($i)
    url=${b[0]}
    host=${b[1]}
    echo "url:$url,host:${host}"
done
