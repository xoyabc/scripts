#!/bin/bash


# 10.90.221.243 -- new
# 10.90.221.243 -- old

max=186400
cout=0

while [ ${cout} -le ${max} ]
do
    TIME=$(date +%Y%m%d\ %H:%M:%S)
    DATE=$(date +%Y%m%d)
    dns_1=$(dig beta-cm-tang.cztf66ungj5h.rds.cn-north-1.amazonaws.com.cn +short A @192.168.96.7)
    dns_2=$(dig beta-cm-tang.cztf66ungj5h.rds.cn-north-1.amazonaws.com.cn +short A @192.168.96.200)
    dns_3=$(dig beta-cm-tang.cztf66ungj5h.rds.cn-north-1.amazonaws.com.cn +short A @10.90.221.174)
    dns_4=$(dig beta-cm-tang.cztf66ungj5h.rds.cn-north-1.amazonaws.com.cn +short A @10.70.103.23)
    LOG_FILE="/tmp/dns.record.${DATE}"
    echo "${TIME} 192.168.96.7 ${dns_1}" >> ${LOG_FILE}
    echo "${TIME} 192.168.96.200 ${dns_2}" >> ${LOG_FILE}
    echo "${TIME} 10.90.221.174 ${dns_3}" >> ${LOG_FILE}
    echo "${TIME} 10.70.103.23 ${dns_4}" >> ${LOG_FILE}
    sleep 1
    ((++cout))
    echo ${cout}
done
