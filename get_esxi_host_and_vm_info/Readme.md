# 获取宿主机及虚拟机信息

运行环境为 Python2.7

## get_esxi_host_and_vm_info.py

 - 1, 在脚本所在路径新建一个`ip.txt`文件，贴入宿主机IP，一行一个IP
 - 2，在main方法修改用户名及密码
 - 3, 运行脚本，执行完后会在脚本所在目录生成一个 `host_list-宿主机-虚拟机.xlsx`，里面存放了宿主机及虚拟机的信息。
``` python
    username = 'root'
    password = '1111111'
    ip_list_file = 'ip.txt'
```

- 宿主机信息概览

![1.jpg](https://i.loli.net/2018/11/01/5bd9e65e0bf34.jpg)

- 虚拟机信息概览

![1.jpg](https://i.loli.net/2018/11/01/5bd9e56fb33e7.jpg)

## to_be_sovled

- [ ] 若虚拟机名称中含有空格，则只会获取空格前的内容。
