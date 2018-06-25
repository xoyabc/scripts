## 应用场景

用于数据备份，以便及时回退。

## 脚本说明

可支持单个文件，多个文件，单个目录，多个目录备份。

默认会检查是否有nginx,openresty,apache等web进程，若有会默认进行备份，第二次执行时会检查是否生成对应的默认备份文件，若有则不备份，交由`BAK_APP_DATA`
函数处理。

`BAK_APP_DATA`使用样例如下：

``` bash
BAK_APP_DATA apache /usr/local/apache apache_default_bak
BAK_APP_DATA openresty /usr/local/openresty/nginx openresty_nginx_default_bak
BAK_APP_DATA nginx /etc/nginx nginx_default_bak
```
其中第一个参数为`进程名`，第二个参数为`程序对应目录`，第三个参数为`默认备份文件名前缀`(注意要保证唯一)，备份位置在目录`/data/backup/当天日期/进程名`中。

## 使用示例

### 未带参数

默认会备份Apache、nginx、openresty的nginx数据。

``` bash
# bash backup_data.sh             
[Info]: Backup directory apache success,the corresponding tar file is /data/backup/20180626/apache/apache_default_bak_20180626_012559.tar.gz 
[Info]: Backup directory nginx success,the corresponding tar file is /data/backup/20180626/nginx/nginx_default_bak_20180626_012559.tar.gz 
[Warning]: 
   USAGE(on local host):
   sample1: bash backup_data.sh filename1
   sample2: bash backup_data.sh filename1 filename2
   sample3: bash backup_data.sh dir1
   sample4: bash backup_data.sh dir1 dir2
   USAGE(using curl):
   sample1: curl -Ss http://192.168.10.101:8080/scripts/backup_data.sh |bash -s filename1
   sample2: curl -Ss http://192.168.10.101:8080/scripts/backup_data.sh |bash -s filename1 filename2
   sample3: curl -Ss http://192.168.10.101:8080/scripts/backup_data.sh |bash -s dir1
   sample4: curl -Ss http://192.168.10.101:8080/scripts/backup_data.sh |bash -s dir1 dir2
```

### 备份单个文件

``` bash
# bash backup_data.sh /etc/hosts
[Info]: Begin to backup file hosts 
[Info]: Backup file hosts success,the corresponding tar file is /data/backup/20180626/hosts_20180626_015104.tar.gz

# tar tf /data/backup/20180626/hosts_20180626_015104.tar.gz
hosts
```

### 备份多个文件

``` bash 
# bash backup_data.sh /etc/ssh/sshd_config /etc/hosts.allow
[Info]: Begin to backup file sshd_config 
[Info]: Backup file sshd_config success,the corresponding tar file is /data/backup/20180626/sshd_config_20180626_015328.tar.gz 
[Info]: Begin to backup file hosts.allow 
[Info]: Backup file hosts.allow success,the corresponding tar file is /data/backup/20180626/hosts.allow_20180626_015328.tar.gz 

# tar tf /data/backup/20180626/sshd_config_20180626_015328.tar.gz 
sshd_config
# tar tf /data/backup/20180626/hosts.allow_20180626_015328.tar.gz               
hosts.allow
```

### 备份单个目录

``` bash 
# bash backup_data.sh /usr/local/curl
[Info]: Begin to backup directory curl 
[Info]: Backup directory curl success,the corresponding tar file is /data/backup/20180626/curl/curl_20180626_015929.tar.gz 

# tar tf /data/backup/20180626/curl/curl_20180626_015929.tar.gz 
curl/
curl/lib/
......
curl/share/man/man3/CURLOPT_USERPWD.3
curl/share/man/man3/curl_getdate.3
curl/bin/
curl/bin/curl-config
curl/bin/curl
```

### 备份多个目录

``` bash 
# bash backup_data.sh /usr/local/pureftpd /usr/local/nginx
[Info]: Begin to backup directory pureftpd 
[Info]: Backup directory pureftpd success,the corresponding tar file is /data/backup/20180626/pureftpd/pureftpd_20180626_020145.tar.gz 
[Info]: Begin to backup directory nginx 
[Info]: Backup directory nginx success,the corresponding tar file is /data/backup/20180626/nginx/nginx_20180626_020145.tar.gz 

# tar tf /data/backup/20180626/pureftpd/pureftpd_20180626_020145.tar.gz 
pureftpd/
pureftpd/etc/
pureftpd/etc/pure-ftpd.conf
pureftpd/etc/pure-ftpd.pem
pureftpd/share/
pureftpd/share/man/
pureftpd/share/man/man8/
......
pureftpd/sbin/pure-ftpd
pureftpd/bin/
pureftpd/bin/pure-pw
pureftpd/bin/pure-statsdecode
pureftpd/bin/pure-pwconvert

# tar tf  /data/backup/20180626/nginx/nginx_20180626_020145.tar.gz 
nginx/
nginx/uwsgi_temp/
nginx/logs/
nginx/logs/error.log
nginx/conf/
nginx/conf/fastcgi_params
nginx/conf/vhost/
......
nginx/proxy_temp/6/
nginx/sbin/
nginx/sbin/nginx
nginx/fastcgi_temp/
nginx/client_body_temp/
```













