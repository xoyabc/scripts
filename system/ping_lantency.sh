#!/bin/bash

DATE=$(date +%Y%m%d%H%M)
LOG_FILE="ping.log"
IP="103.120.227.225"

[ ! -f ${LOG_FILE} ] && touch ${LOG_FILE}

# translates into 1024 ICMP data bytes when combined with the 8 bytes of ICMP header data and 4 bytes of of Ethernet checksum.
lantency=$(ping -c 59 -s 1012 ${IP} |awk -F "[/ ]+" '{if($0~/loss/) {printf"%s ", $6} else if(/rtt/) {print $7,$8,$9} }')

echo "${DATE} ${lantency}" >> ${LOG_FILE}

# date/loss rate/min/avg/max
if [ $(cat ${LOG_FILE} |grep max |wc -l) -lt 1 ]
then
        sed -i '1i date loss_rate min avg max' ${LOG_FILE}
fi 
