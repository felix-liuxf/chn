---
title: linux 7 防火墙 firewall
---
### 查看防火墙是否启用
- firewall-cmd --state
### centos7启动防火墙
- systemctl start firewalld.service
### centos7停止防火墙/关闭防火墙
- systemctl stop firewalld.service
### centos7重启防火墙
- systemctl restart firewalld.service
 
 
### 设置开机启用防火墙
- systemctl enable firewalld.service
### 设置开机不启动防火墙
- systemctl disable firewalld.service

### 新增开放一个端口号
- firewall-cmd --zone=public --add-port=80/tcp --permanent
 
说明:
 –zone #作用域
 –add-port=80/tcp #添加端口，格式为：端口/通讯协议
 –permanent 永久生效，没有此参数重启后失效 

### 添加多个端口:
- firewall-cmd --zone=public --add-port=80-90/tcp --permanent

### 删除端口
- firewall-cmd --zone=public --remove-port=80/tcp --permanent

### 实现5423–>80端口转发
- firewall-cmd --permanent --zone=trusted --add-forward-port=port=5423:proto=tcp:toport=80 //添加永久配置

### 查看防火墙信息

centos7查看防火墙所有信息
- firewall-cmd --list-all
centos7查看防火墙开放的端口信息
- firewall-cmd --list-ports


