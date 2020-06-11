#!/bin/bash
# **********************************************************
# * Author        : xoyabc
# * Email         : lxh1031138448@gmail.com
# * Last modified : 2020-06-09 00:48
# * Filename      : generate_url_link.sh
# * Description   : get download link
# **********************************************************


WEB_ROOT_DIR="/www"
PORT="8080"
WEB_ROOT_DIR_ESP=$(echo ${WEB_ROOT_DIR} |sed 's#/#\\/#g')
CURRENT_DIR="${PWD}"
IP=$(ip a|awk --re-interval '/(eth|ens[0-9]+)/ && $0!~/\/32/ && $2~/^10.|^192.168.|^172.(1[6-9]|2[0-9]|3[0-1])/{split($2,a,"/");print a[1]}')

warn_echo(){
    echo -e "\033[40;93m[Warning]: $1 \033[0m"
}
info_echo(){
    echo -e "\033[40;32m[Info]: $1 \033[0m"
}

function gen_link ()
{
    FILE="$1"
    #PWD=$(which pwd)
    
    [ $# -ne 1 ] && echo "Usage: bash $0 filename"
    
    # output download link if the path exists
    if [ -f ${FILE} ]
    then
        if `echo ${FILE} |grep -Eq "^${WEB_ROOT_DIR}"`
        # deal with absolute path
        then
            URI=$(echo ${FILE} |sed -r "s/^${WEB_ROOT_DIR_ESP}(.*)$/\1/")
            URL="http://${IP}:${PORT}${URI}"
        # deal with relative path which starts with "../../" or “../” or ../../../dir1/dir2/filename
        # such as ../../filename
        elif `echo ${FILE} |grep -Eq "^\.\."`
        then
            FILENAME=$(basename ${FILE})
            DIR_NUM=$(echo ${FILE} | grep -Eo '\.\.\/' |wc -l)
            #DIR_NUM=$((${DOT_NUM}/2))
            REAL_DIR_NAME_PRE=$(echo ${CURRENT_DIR} |awk -F "/" -v "dir_num=${DIR_NUM}" 'OFS="/"{temp=NF-dir_num;for(i=2;i<=temp;i++) {printf "/%s",$i}}' )
            REAL_DIR_NAME_POST=$(dirname ${FILE} |sed -r 's#(\.\.\/|\.\.)##g')
            [ -z ${REAL_DIR_NAME_POST} ] && REAL_DIR_NAME="${REAL_DIR_NAME_PRE}" || REAL_DIR_NAME="${REAL_DIR_NAME_PRE}/${REAL_DIR_NAME_POST}"
            URI=$(echo ${REAL_DIR_NAME} |sed "s/${WEB_ROOT_DIR_ESP}//g")
            URL="http://${IP}:${PORT}${URI}/${FILENAME}"
        # deal with relative path 
        else
            URI=$(echo ${CURRENT_DIR} |sed "s/${WEB_ROOT_DIR_ESP}//g")
            URL="http://${IP}:${PORT}${URI}/${FILE}"
        fi
        
        echo ${URL}
    # output err message if the path does not exist 
    else
        warn_echo "cannot access ${FILE}: No such a file or directory"
    fi
}


main(){
    if [ $# -lt 1 ];then
      echo "USAGE:l FILENAME"
      exit 1
    fi
    # deal with "l *"
    for FILENAME in $*
    do
            #echo ${FILENAME}
            # deal with dir, require either one condition as follows
            # 1, relative directory
            # 2, absolute directory
            if [ -d ${FILENAME} ] && ( `echo ${FILENAME} |grep -Eq "^${WEB_ROOT_DIR}"` || `echo ${CURRENT_DIR} |grep -Eq "^${WEB_ROOT_DIR}"` )
            then
		FILE_NUM=$(find ${FILENAME} -type f |wc -l)
		# output file download link if the dir has more than one file
		if [ ${FILE_NUM} -ge 1 ]
		then
                    find ${FILENAME} -type f |while read file
                    do
                        gen_link ${file}
                    done
		else
		    warn_echo "There is no file under ${FILENAME} directory"
		fi 
            else
                gen_link ${FILENAME}
            fi
    done
}

main $*
