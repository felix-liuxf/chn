---
title: 配置vsftp服务器
---

## 安装brew
>用mac自带的mac下载，去https://brew.sh/index_zh-cn.html 复制命令
## 安装vsftpd
- brew install vsftpd
- brew安装完vsftpd后会给出以下提示：
```
To use chroot, vsftpd requires root privileges, so you will need to run
sudo vsftpd.
You should be certain that you trust any software you grant root privileges.

The vsftpd.conf file must be owned by root or vsftpd will refuse to start:
sudo chown root /usr/local/etc/vsftpd.conf

To have launchd start vsftpd now and restart at startup:
sudo brew services start vsftpd
Or, if you don’t want/need a background service you can just run:
sudo vsftpd
```
>运行命令：sudo chown root /usr/local/etc/vsftpd.conf

## 修改配置文件vsftpd.conf：

- local_enable=YES
- write_enable=YES

## 新建一个用户：

ftp1，并设置密码。mac中不能使用命令useradd，所以要到系统偏好设置->用户与群主 中新增用户。
启动vaftpd：sudo brew services start vsftpd
在/etc/shells中新增/bin/false和/sbin/nologin，这样可以允许ftp登录，禁止ssh登录，如果没有这个需要可以不用设置。
用ftp1登录，可能会报以下错误
## 重启vsftpd 
sudo brew services restart vsftpd, 重新登录ftp1,报错：
331 Please specify the password. 530 Login incorrect.
解决方法：

cd /etc/pam.d, 找到ftp server的名字，我找到的是ftpd。
在vsftpd.conf加上pam_service_name=ftpd

重启vsftpd

上述步骤完成之后就可以使用127.0.0.1访问该ftp服务器了。

## 修改默认目录
```
修改ftp的根目录只要修改/usr/local/etc/vsftpd.conf文件即可：

加入如下几行：

local_root=/var/www/html
chroot_local_user=YES
anon_root=/var/www/html

注：local_root 针对系统用户；anon_root 针对匿名用户。
```

