# OCI Block Volume
### Attach Block Volume
- sudo fdisk /dev/sdb
- n,,,wq
- sudo mkfs -t ext4 /dev/sdb1
- sudo mount /dev/sdb1 /u01
