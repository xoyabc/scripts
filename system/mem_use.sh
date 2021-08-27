#!/bin/bash



max=7864000
cout=0

while [ ${cout} -le ${max} ]
do
    TIME=$(date +%Y%m%d\ %H:%M:%S)
    DATE=$(date +%Y%m%d)
    LOG_FILE="/tmp/mem.use.${DATE}"
    test -f ${LOG_FILE} || touch ${LOG_FILE}
    echo ${cout}
    echo ${TIME}
    echo ${TIME} >> ${LOG_FILE}
    ps -eo pid,ppid,vsz,rss,cmd |sort -nr -k3 |head >> ${LOG_FILE}
    sleep 5
    # clear old log
    find /tmp -type f -iname "cpu.use*" -mtime +7 -delete
    ((++cout))
done
