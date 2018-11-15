#!/bin/bash
# delete old files,just save files in 30 days
DAY_DELETE_1="30"
# delete old files,just save files in 20 days
DAY_DELETE_2="20"
# delete old files,just save files in 60 days
DAY_DELETE_3="60"
declare -a APP_LOG_DIR_1
APP_LOG_DIR_1=(
/var/log/pc3.0
/var/log/apache2
/var/log/uclog
)
declare -a APP_LOG_DIR_2
APP_LOG_DIR_2=(
/var/log/pstnus
)
declare -a APP_LOG_DIR_3
APP_LOG_DIR_3=(
/var/log/tang
/var/log/tangjava
)

function clean_old_logfile_1()
{
    # clean log file
    for dir in ${APP_LOG_DIR_1[*]}
    do
        [ -d ${dir} ] && find ${dir} -regextype posix-extended -regex '.*\.(log|gz).?([0-9]{1,2}){0,1}' -type f -mtime +${DAY_DELETE_1} -delete
    done
}
function clean_old_logfile_2()
{
    # clean log file
    for dir in ${APP_LOG_DIR_2[*]}
    do
        [ -d ${dir} ] && find ${dir} -regextype posix-extended -regex '.*\.(log|gz).?([0-9]{4}-[0-9]{1,2}-[0-9]{1,2}){0,1}' -type f -mtime +${DAY_DELETE_2} -delete
    done
}
function clean_old_logfile_3()
{
    # clean log file, clear uncut log file 
    for dir in ${APP_LOG_DIR_3[*]}
    do
        [ -d ${dir} ] && find ${dir} -regextype posix-extended -regex '.*\.(log|gz).?([0-9]{4}-[0-9]{1,2}-[0-9]{1,2}){0,1}' -type f -mtime +${DAY_DELETE_3} -delete
        [ -d ${dir} ] && find ${dir} . -type f -iname "*.log" -size +20G -exec dd if=/dev/null of={} \;
    done
       
}

clean_old_logfile_1
clean_old_logfile_2
clean_old_logfile_3
