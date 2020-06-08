## 应用场景

针对装有 web 服务(nginx, apache) 的 server,在 web 目录下生成下载链接。

配合别名使用，效果更佳。

此处根目录为 /www，别名为 `l`

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
http://172.17.40.100:8080/conf/cfg.json
```

### 单个文件（绝对路径）

```shell
root@ss:/www/conf$l /www/conf/cfg.json 
http://172.17.40.100:8080/conf/cfg.json
```

### 多个文件（相对路径）

```shell
root@ss:/www/conf$l cfg.json conf.sh 
http://172.17.40.100:8080/conf/cfg.json
http://172.17.40.100:8080/conf/conf.sh
```

### 多个文件（绝对路径）

```shell
root@ss:/www/conf$l /www/conf/cfg.json /www/conf/conf.sh 
http://172.17.40.100:8080/conf/cfg.json
http://172.17.40.100:8080/conf/conf.sh
```

### 单个目录（相对路径）

```shell
root@ss:/www/conf/test/20200608$l ../20200608/ 
http://172.17.40.100:8080/conf/test/20200608/2
http://172.17.40.100:8080/conf/test/20200608/3
http://172.17.40.100:8080/conf/test/20200608/1
```

### 单个目录（绝对路径）

```shell
root@ss:/www/conf/test/20200608$l /www/conf/test/20200608
http://172.17.40.100:8080/conf/test/20200608/2
http://172.17.40.100:8080/conf/test/20200608/3
http://172.17.40.100:8080/conf/test/20200608/1
```

### 多个目录（相对路径）

```shell
root@ss:/www/conf/test$l 20200608  20200609
http://172.17.40.100:8080/conf/test/20200608/2
http://172.17.40.100:8080/conf/test/20200608/3
http://172.17.40.100:8080/conf/test/20200608/1
http://172.17.40.100:8080/conf/test/20200609/2
http://172.17.40.100:8080/conf/test/20200609/3
http://172.17.40.100:8080/conf/test/20200609/1
```

### 多个目录（绝对路径）

```shell
root@ss:/www/conf/test$l /www/conf/test/20200608  /www/conf/test/20200609
http://172.17.40.100:8080/conf/test/20200608/2
http://172.17.40.100:8080/conf/test/20200608/3
http://172.17.40.100:8080/conf/test/20200608/1
http://172.17.40.100:8080/conf/test/20200609/2
http://172.17.40.100:8080/conf/test/20200609/3
http://172.17.40.100:8080/conf/test/20200609/1
```

### 通配符

```shell
root@ss:/www/conf/test/20200608$ls
1  2  3
root@ss:/www/conf/test/20200608$
root@ss:/www/conf/test/20200608$
root@ss:/www/conf/test/20200608$l *
http://172.17.40.100:8080/conf/test/20200608/1
http://172.17.40.100:8080/conf/test/20200608/2
http://172.17.40.100:8080/conf/test/20200608/3
```
