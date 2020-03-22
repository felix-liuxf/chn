### 查看selinux状态
- sestatus
### disable selinux
- sudo setenforce 0 
### enable selinux
- sudo setenforce 1

### 修改配置文件设置selinux

```
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#       enforcing - SELinux security policy is enforced.
#       permissive - SELinux prints warnings instead of enforcing.
#       disabled - No SELinux policy is loaded.
SELINUX=disabled
# SELINUXTYPE= can take one of these two values:
#       targeted - Targeted processes are protected,
#       mls - Multi Level Security protection.
SELINUXTYPE=targeted
```

### 系统重启动后生效

### Reference Link
-https://linuxize.com/post/how-to-disable-selinux-on-centos-7/