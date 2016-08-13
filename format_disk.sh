#!/bin/bash
#initialize the disk

df -h|grep -v "data100" > /tmp/disk_mount_info
disk_info="/tmp/disk_mount_info"

/etc/init.d/flexicache stop >/dev/null 2>&1

sleep 10

#deal with a/data/proclog
num_proclog=$(df -h |grep /data/proclog |wc -l )
if [ ${num_proclog} -eq 1 ]
then
        partition=$(df -h |grep /data/proclog|awk '{print $1}')
        mountpoint=$(df -h |grep /data/proclog|awk '{print $6}')
        fuser -km ${mountpoint}
        umount -f ${mountpoint}
        [[ ! -d /data/proclog ]] && mkdir -p /data/proclog
        mkfs.ext4 ${partition} -L /data/proclog > /dev/null 2>&1 &
        while true
        do
                sleep 30
                ps -ef|grep mkfs.ext4|grep -v grep > /dev/null 2>&1
                if [ $? -ne 0 ]
                then
                        break
                fi
        done
                mount -L /data/proclog ${mountpoint}
                if [ $? -ne 0 ]
                then
                        echo "Warning: mount ${partition} to ${mountpoint} FAIL!"
                fi
        sed -i '/\/data\/proclog/ d' /etc/fstab
        proclog_mount_info=$(df -h | grep "/data/proclog" | awk '{print "LABEL="$NF,"   ",$NF,"\t       ","ext4","  ","defaults","\t","0"," ","0"}')
        sed -i "1a ${proclog_mount_info}" /etc/fstab

fi

#deal with cache_dir
i=0
while read line
do
        mountpoint=`echo $line|awk '{print $6}'`
        if [ "$mountpoint" = "/data/proclog" ]
        then
                continue
        fi

        if [[ "${mountpoint}" =~ "/data" ]]
        then
                partition=`echo $line|awk '{print $1}'`
                PARTITION[$i]=$partition
                MOUNTPOINT[$i]=$mountpoint
                echo ${PARTITION[$i]}
                echo ${MOUNTPOINT[$i]}
                let i=i+1
        fi

done < ${disk_info}



#echo ${#PARTITION[*]}

if [ ${#PARTITION[*]} -gt 0 ]
then
        #leng=0
        #while [ $leng -lt "${#PARTITION[*]}" ]
        #do
        #       echo "${PARTITION[$leng]}       ${MOUNTPOINT[$leng]}"
        #       let leng=leng+1
        #done

        i=0
        while [ $i -lt "${#MOUNTPOINT[*]}" ]
        do
                fuser -km ${MOUNTPOINT[$i]}
                umount -f ${MOUNTPOINT[$i]}
                
                let num=i+1
                cache_dir="/data/cache${num}"
                [[ ! -d ${cache_dir} ]] && mkdir -p ${cache_dir}
                mkfs.ext4 ${PARTITION[$i]}  > /dev/null 2>&1 &
                let i=i+1
        done

        while true
        do
                sleep 30
                ps -ef|grep mkfs.ext4|grep -v grep > /dev/null 2>&1
                if [ $? -ne 0 ]
                then
                        break
                fi
        done

        #mount the disk and add mount info to /etc/fstab
        i=0
        num=1
        while [ $i -lt "${#MOUNTPOINT[*]}" ]
        do
                cache_dir="/data/cache${num}"
                mount ${PARTITION[$i]} ${cache_dir}
                if [ $? -ne 0 ]
                then
                        echo "Warning: mount ${PARTITION[$i]} to ${cache_dir} FAIL!"
                fi
                let i=i+1
                let num=num+1
        done

        sed -i '/\/data[0-9]/ d' /etc/fstab; 
        sed -i '/\/data\/cache*/ d' /etc/fstab; 
        df -h | grep -E "/data/cache" | awk '{print $1,"\t\t",$NF,"\t","ext4","   ","noatime,nodiratime","\t","0","   ","0"}' >> /etc/fstab
        exit 0
fi
