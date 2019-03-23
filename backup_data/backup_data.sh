#!/bin/bash
# **********************************************************
# * Author        : xoyabc
# * Email         : lxh1031138448@qq.com
# * Last modified : 2018-06-26 01:01
# * Filename      : backup_data.sh
# * Description   : 
# **********************************************************
warn_echo(){
    echo -e "\033[40;93m[Warning]: $1 \033[0m"
}
info_echo(){
    echo -e "\033[40;32m[Info]: $1 \033[0m"
}

DATE=$(date +"%Y%m%d_%H%M%S")
DATE_DIR=$(date +"%Y%m%d")
BAK_PATH="/data/backup/${DATE_DIR}"
[ ! -d ${BAK_PATH} ] && mkdir -p ${BAK_PATH}

function BAK_DATA ()
{
        DIR_OR_FILE="$1"
        # deal with dir
        if [ -d ${DIR_OR_FILE} ]
        then
                parent_dir=$(dirname ${DIR_OR_FILE})
                base_dir=$(basename ${DIR_OR_FILE})
                bak_dir="${BAK_PATH}/${base_dir}"
                echo "${DIR_OR_FILE}" | grep -q "/usr/local/openresty/nginx" && bak_tar_filename="openresty_${base_dir}_${DATE}" || bak_tar_filename="${base_dir}_${DATE}"
                [ ! -d ${bak_dir} ] && mkdir -p ${bak_dir}
                info_echo "Begin to backup directory ${base_dir}"
                tar zcpf ${bak_dir}/${bak_tar_filename}.tar.gz -C ${parent_dir} ${base_dir}
                res=$?
                if [ ${res} -eq 0 ]
                then
                        info_echo "Backup directory ${base_dir} success,the corresponding tar file is ${bak_dir}/${bak_tar_filename}.tar.gz"
                else
                        warn_echo "Backup directory ${base_dir} failed"
                fi
        # deal with file
        elif [ -f ${DIR_OR_FILE} ]
        then
                parent_dir=$(dirname ${DIR_OR_FILE})
                base_filename=$(basename ${DIR_OR_FILE})
                bak_dir="${BAK_PATH}"
                [ ! -d ${bak_dir} ] && mkdir -p ${bak_dir}
                info_echo "Begin to backup file ${base_filename}"
                tar zcpf ${bak_dir}/${base_filename}_${DATE}.tar.gz -C ${parent_dir} ${base_filename} &>/dev/null
                res=$?
                if [ ${res} -eq 0 ]
                then
                        info_echo "Backup file ${base_filename} success,the corresponding tar file is ${bak_dir}/${base_filename}_${DATE}.tar.gz"
                else
                        warn_echo "Backup file ${base_filename} failed"
                fi
        else
                warn_echo "There is no such a file or directory named ${DIR_OR_FILE}"
        fi
}

# backup import web data
function BAK_APP_DATA ()
{
        #process_name="apache"
        #app_dir="/usr/local/apache"
        #bak_tar_prefix="apache_default_bak"
        process_name="$1"
        app_dir="$2"
        bak_tar_prefix="$3"
        bak_dir="${BAK_PATH}/${process_name}"
        bak_tar_filename="${bak_tar_prefix}_${DATE}"
        parent_dir=$(dirname ${app_dir})
        base_dir=$(basename ${app_dir})
        [ -d ${app_dir} ] && [ ! -d ${bak_dir} ] && mkdir -p ${bak_dir}
        num_of_defalut_bak_tar=$(find ${BAK_PATH} -type f -regextype posix-extended -regex ".*/${bak_tar_prefix}.*" |wc -l)
        if [ ${num_of_defalut_bak_tar} -lt 1 ] && ps -ef |grep -v grep |grep ${process_name} &>/dev/null
        then
                [ -d ${app_dir} ] && tar zcpf ${bak_dir}/${bak_tar_filename}.tar.gz -C ${parent_dir} ${base_dir}
                res=$?
                if [ ${res} -eq 0 ]
                then
                        info_echo "Backup directory ${base_dir} success,the corresponding tar file is ${bak_dir}/${bak_tar_filename}.tar.gz"
                else
                        warn_echo "Backup directory ${app_dir} failed"
                fi
        fi
}

BAK_APP_DATA apache /usr/local/apache/conf apache_default_bak
#BAK_APP_DATA openresty /usr/local/openresty/nginx openresty_nginx_default_bak
#BAK_APP_DATA nginx /etc/nginx nginx_default_bak

Usage(){
   warn_echo "
   USAGE(on local host):
   sample1: bash backup_data.sh filename1
   sample2: bash backup_data.sh filename1 filename2
   sample3: bash backup_data.sh dir1
   sample4: bash backup_data.sh dir1 dir2
   USAGE(using curl):
   sample1: curl -Ss http://192.168.10.101:8080/scripts/backup_data.sh |bash -s filename1
   sample2: curl -Ss http://192.168.10.101:8080/scripts/backup_data.sh |bash -s filename1 filename2
   sample3: curl -Ss http://192.168.10.101:8080/scripts/backup_data.sh |bash -s dir1
   sample4: curl -Ss http://192.168.10.101:8080/scripts/backup_data.sh |bash -s dir1 dir2"
   exit 1
}

main(){
if [ $# -lt 1 ];then
  Usage
fi
for BAK_DIR_OR_FILENAME in $*
do
        [ ! -z ${BAK_DIR_OR_FILENAME} ] && BAK_DATA ${BAK_DIR_OR_FILENAME}
done
}

main $*
