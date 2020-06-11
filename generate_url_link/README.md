
      * [应用场景](#应用场景)
         * [nginx 配置示例](#nginx-配置示例)
         * [设置别名](#设置别名)
      * [使用示例](#使用示例)
         * [单个文件（相对路径）](#单个文件相对路径)
         * [单个文件（绝对路径）](#单个文件绝对路径)
         * [多个文件（相对路径）](#多个文件相对路径)
         * [多个文件（绝对路径）](#多个文件绝对路径)
         * [单个目录（相对路径）](#单个目录相对路径)
         * [单个目录（绝对路径）](#单个目录绝对路径)
         * [多个目录（相对路径）](#多个目录相对路径)
         * [多个目录（绝对路径）](#多个目录绝对路径)
         * [通配符](#通配符

## 应用场景

针对装有 web 服务(nginx, apache) 的 server,对指定根目录下的文件生成下载链接，方便其他机器下载使用。

配合别名使用，效果更佳。

此处根目录为 /www，别名为 `l`

### nginx 配置示例

```shell
server {
        listen 8080 default_server;
        server_name  localhost;
        listen [::]:8080 default_server ipv6only=on;
        charset utf-8;
        access_log  /var/log/nginx/8080.access.log;
        root   /www;
        index  index.html index.htm index.php;

        location / {
                try_files $uri $uri/ /index.html; 
        }

        error_page  404  /404.html;

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
}
```
### 设置别名

```shell
alias l='bash /www/generate_url_link.sh'
```

目前支持：

 - [x] 相对路径及绝对路径下的单个文件或目录
 - [x] 相对路径及绝对路径下的多个文件或目录。


## 使用示例

### 单个文件（相对路径）

```shell
root@ss:/www/conf/openresty$l ../cfg.json 
http://192.168.1.200:8080/conf/cfg.json
```

### 单个文件（绝对路径）

```shell
root@ss:/www/conf$l /www/conf/cfg.json 
http://192.168.1.200:8080/conf/cfg.json
```

### 多个文件（相对路径）

```shell
root@ss:/www/conf$l cfg.json conf.sh 
http://192.168.1.200:8080/conf/cfg.json
http://192.168.1.200:8080/conf/conf.sh
```

### 多个文件（绝对路径）

```shell
root@ss:/www/conf$l /www/conf/cfg.json /www/conf/conf.sh 
http://192.168.1.200:8080/conf/cfg.json
http://192.168.1.200:8080/conf/conf.sh
```

### 单个目录（相对路径）

```shell
root@ss:/www/conf/test/20200608$l ../20200608/ 
http://192.168.1.200:8080/conf/test/20200608/2
http://192.168.1.200:8080/conf/test/20200608/3
http://192.168.1.200:8080/conf/test/20200608/1
```

### 单个目录（绝对路径）

```shell
root@ss:/www/conf/test/20200608$l /www/conf/test/20200608
http://192.168.1.200:8080/conf/test/20200608/2
http://192.168.1.200:8080/conf/test/20200608/3
http://192.168.1.200:8080/conf/test/20200608/1
```

### 多个目录（相对路径）

```shell
root@ss:/www/conf/test$l 20200608  20200609
http://192.168.1.200:8080/conf/test/20200608/2
http://192.168.1.200:8080/conf/test/20200608/3
http://192.168.1.200:8080/conf/test/20200608/1
http://192.168.1.200:8080/conf/test/20200609/2
http://192.168.1.200:8080/conf/test/20200609/3
http://192.168.1.200:8080/conf/test/20200609/1
```

### 多个目录（绝对路径）

```shell
root@ss:/www/conf/test$l /www/conf/test/20200608  /www/conf/test/20200609
http://192.168.1.200:8080/conf/test/20200608/2
http://192.168.1.200:8080/conf/test/20200608/3
http://192.168.1.200:8080/conf/test/20200608/1
http://192.168.1.200:8080/conf/test/20200609/2
http://192.168.1.200:8080/conf/test/20200609/3
http://192.168.1.200:8080/conf/test/20200609/1
```

### 通配符

```shell
root@ss:/www/conf/test/20200608$ls
1  2  3
root@ss:/www/conf/test/20200608$
root@ss:/www/conf/test/20200608$
root@ss:/www/conf/test/20200608$l *
http://192.168.1.200:8080/conf/test/20200608/1
http://192.168.1.200:8080/conf/test/20200608/2
http://192.168.1.200:8080/conf/test/20200608/3
```

