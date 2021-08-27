#!/bin/bash

mkdir -p /opt/tmp
netstat -ntpl |grep -Ev 'rpc|zabbix|ssh' |sort -t '/' -k2 > /opt/tmp/sysinfo_netstat
ps -ef |grep -E 'tang|tomcat' |grep -v mfsmount |grep -v grep > /opt/tmp/sysinfo_tang_process_list
ps -ef |grep '[m]fsmount' > /opt/tmp/sysinfo_mfs_process_list
ps -ef |awk '{$1=$2=$3=$4=$5=$6=$7=null;print}' |sed -r 's/^\s*//g'|sort -u |grep -Ev 'su -|-su|sshd|watchdog|xenbus|xenwatch|kworker|rcu_bh|rcu_sched|rsyslogd|getty|scsi_|init|perf|vmstat|writeback|scsi_|migration|\[|cron|CMD|/bin/bash|-bash|awk|atd|acpid|sed|sort|systemd|ps -ef|dbus|upstart-|irqbalance|dhclient|sz |rpcbind|rpc.|vmtoolsd|mysql |vi |vim |bash|echo|ping|/bin/sh |sudo |/usr/local/bin/mfsmount|/usr/sbin/inetd|ansible' > /opt/tmp/sysinfo_all_process_list
df -hT > /opt/tmp/sysinfo_disk_mount
