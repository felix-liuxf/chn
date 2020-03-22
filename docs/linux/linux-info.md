---
title: 查看系统信息
---
## CPU 信息
 总核数 = 物理CPU个数 X 每颗物理CPU的核数 
 总逻辑CPU数 = 物理CPU个数 X 每颗物理CPU的核数 X 超线程数

### 查看物理CPU个数
- cat /proc/cpuinfo| grep "physical id"| sort| uniq| wc -l

### 查看每个物理CPU中core的个数(即核数)
- cat /proc/cpuinfo| grep "cpu cores"| uniq

### 查看逻辑CPU的个数
- cat /proc/cpuinfo| grep "processor"| wc -l

## 添加用户到sudo
- set a special rule for this user in the /etc/sudoers file using the following (note that there is no %, which is used to denote a group):
- oracle    ALL=(ALL:ALL) ALL
- usermod -a -G wheel felix    //注意改成你自己的用户名

## scp example
- scp -r root@192.168.62.10:/root/ .
##  批量杀死进程
- ps -ef | grep oracle | grep -v grep | awk '{print "kill -9 "$2}' | sh

## 计算多少行
- ps -ef |wc -l

