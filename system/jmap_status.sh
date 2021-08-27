java_home="/usr/local/jdk/bin"
log_path="/var/log/jmap"
Date=$(date +"%Y-%m-%d")
log_date=$(date +"%Y-%m-%d %H:%M")
 
#/bin/rm -fr $log_path/*
 
if [ ! -d $log_path/$Date ]; then
    /bin/mkdir -p $log_path/$Date
fi
 
p=$(ps aux | grep java | grep -v grep | head -3 | awk '{print $2}' | xargs)
for pid in $p
do
    /bin/echo -e "$log_date:" >> $log_path/$Date/jvm.heap
    $java_home/jmap -heap $pid >> $log_path/$Date/jvm.heap
    /bin/echo -e "$log_date:" >> $log_path/$Date/jvm.histo
    $java_home/jmap -histo $pid >> $log_path/$Date/jvm.histo
done
 
$java_home/jmap -dump:format=b,file=$log_path/$Date/jvm.dump $pid
