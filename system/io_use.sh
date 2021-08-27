#!/bin/bash



max=7864000
cout=0

while [ ${cout} -le ${max} ]
do
    TIME=$(date +%Y%m%d\ %H:%M:%S)
    DATE=$(date +%Y%m%d)
    LOG_FILE="/tmp/io.use.${DATE}"
    test -f ${LOG_FILE} || touch ${LOG_FILE}
    echo ${cout}
    echo ${TIME}
    echo -e "\n${TIME}" >> ${LOG_FILE}
    iotop -n 3 -d 1 >> ${LOG_FILE}
    sleep 2
    # clear old log
    find /tmp -type f -iname "io.use*" -mtime +7 -delete
    ((++cout))
done
