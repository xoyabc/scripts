#!/bin/bash

DATE=$(date +%Y%m%d%H%M)
LOG_FILE="ping.log"
IP="192.168.1.1"

[ ! -f ${LOG_FILE} ] && > ${LOG_FILE}

# date/loss rate/min/avg/max
if [ $(cat ${LOG_FILE} |grep max |wc -l) -lt 1 ]
then
        sed -i '1i time IP loss_rate min avg max' ${LOG_FILE}
fi 

# translates into 1024 ICMP data bytes when combined with the 8 bytes of ICMP header data and 4 bytes of of Ethernet checksum.
lantency=$(ping -c 59 -s 1012 ${IP} |awk -F "[/ ]+" '{if($0~/loss/) {printf"%s ", $6} else if(/rtt/) {print $7,$8,$9} }')

echo "${DATE} ${IP} ${lantency}" >> ${LOG_FILE}
