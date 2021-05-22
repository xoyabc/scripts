#!/bin/bash

# 以蓝光版英文字幕为准，去WEB或DVD版中英字幕文件中查找对应的英字
# 若单词个数重复率超过90%，则自动将对应中文字幕插入到蓝光字幕文件中，实现原盘双语字幕。

# eng 为蓝光版英文字幕，srt 格式，文件内容示例见下：
# 00:00:56,626 --> 00:00:58,834
# We're going to see that wedding.

# chs_eng 为WEB或DVD版中英字幕，srt 格式，需满足中字在上英字在下，文件内容示例见下：
#1
#00:00:56,626 --> 00:00:58,834
#我们要去观摩婚礼
#We're going to see that wedding.
#
#2
#00:00:58,959 --> 00:01:01,667
#可你们回家还不到5分钟
#But you haven't been home five minutes.

# backup eng
\cp eng eng.bak

#cat eng |awk 'NR>1'|head -n 10 |sed '/^\s*$/d' |grep -Ev '^[0-9]{1,}' |while read line
cat eng |awk 'NR>1' |sed '/^\s*$/d' |grep -Ev '^[0-9]{1,}' |while read line
do 
        echo "hahaha:${line}"
		# 蓝光版单词个数
        total_eng_word_num=$(echo ${line} |awk -F "[ ]+" '{print NF}')
        # 去除中英字幕里的时间轴行及字幕序号，只保留字幕内容
        cat chs_eng |awk 'NR>1' |sed '/^\s*$/d' |grep -Ev '^[0-9]{1,}$|([0-9]{2}:){2}[0-9]{2}' |awk --posix -F "" '{if($1~/^[0-9a-zA-Z]/) print $0}' |while read t_line
        do
		    # DVD/WEBDL 单词个数
            total=$(echo ${t_line} |awk -F "[ ]+" '{print NF}')
            cout=0
            for i in $line
            do
                if `echo "${t_line}" |grep -Ewiq ${i}`
                then
                        let cout+=1
                        #echo ${cout}
                fi
            done
			
            dup_percent=$(echo "${cout} ${total}"|awk '{printf"%d",$1/$2*100}')
            cout_of_word=$(echo "${total_eng_word_num} ${total}" |awk '{d=$1-$2;print (d>0)?d:-d}')
            #echo ${dup_percent}
            #echo "cout/total: ${cout}/${total}=${dup_percent}%"
			# 1，重复率大于 90%
			# 2，蓝光版与 DVD/WEBDL 单词数相差不超过3个 
            if (( ${dup_percent} >= 90 )) && (( ${cout_of_word} <=3 )) 
            then
                    #echo ${line}
                    #echo ${t_line}
                    #sed -n "/${t_line}/{x;p};h" chs_eng
					# 根据英字找对应中字（英字上一行）
                    cn_sub_content=$(sed -n "/${t_line}/{x;p};h" chs_eng |head -n 1)
                    sed -i "/${line}/i ${cn_sub_content}" eng 
                    break
            else
                    cn_sub_content="null"
                    #sed "/${line}/i ${cn_sub_content}" eng
            fi
        done
done
