###  Protecting Data on NVMe Devices

### 查看磁盘信息
- lsblk -f

### Raid 10
-  sudo mdadm --create /dev/md0 --raid-devices=8 --level=10 /dev/nvme0n1 /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1 /dev/nvme4n1 /dev/nvme5n1 /dev/nvme6n1 /dev/nvme7n1

### fdisk partition
- fdisk /dev/md0
- g,-n,-w 

### format disk and mount
- mkfs -t ext4 /dev/md0p1
- mount /dev/md0p1 /u01

### Reference Link
- https://docs.cloud.oracle.com/iaas/Content/Compute/References/nvmedeviceinformation.htm
- https://blog.csdn.net/Catsoup/article/details/87342016