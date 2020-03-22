---
title: OCI VM
---
## Boot Volume 查看磁盘信息
- lsblk
## 进行分区
- parted fixed partition
- fdisk /dev/sda
- reboot
- mkfs -t ext4 /dev/sda4
- mount /dev/sda4 /u01
- mkdir /u01/home
- cp -R /home/opc /u01/home
- chown -R opc:opc /u01/home/opc
- usermod -d /u01/home/opc opc
- fstab  /dev/sda4 /u01 ext4 defaults 0 0

### usermode: user opc is currently used by process
- you must kill currently used process first. But this process probably is your SSH connection. So, in this case you need to run this commands on nohup.
- nohup kill 23795;sleep 2; usermod -d /u01/home/opc opc&
## VM 修改hostname
- [修改Hostname](https://einstein.oracle.com/apex/f?p=300000:Q:106410300071800::NO::QUESTION:impact-of-setting-preserve-hostinfo-2-in-the-etc-oci-hostname-conf-file-1900)
## oci 打开ping功能 

>0.0.0.0/0      ICMP                    8       ICMP traffic for: 8 Echo

## Reference Link
- [parted boot volume](https://docs.cloud.oracle.com/iaas/Content/Block/Tasks/extendingbootpartition.htm?Highlight=parted)
- [linux fstab](https://qiita.com/chinaperfirect/items/a525e4db0fae036b94f5)
- [ext4&xfs](https://blog.csdn.net/zhouchang3/article/details/52996100)
- [fdisk parted](https://www.cnblogs.com/MYSQLZOUQI/p/4818174.html)
