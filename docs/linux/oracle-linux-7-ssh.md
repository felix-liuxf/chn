### SSH登录时开启密码登录模式
- 修改/etc/ssh/sshd_config文件 PasswordAuthentication no ->  PasswordAuthentication yes

### 允许root用户远程登录
- PermitRootLogin yes

### 允许无密码登录
- PermitEmptyPasswords


### 客户端是putty
- 那么请确认”尝试’智能键盘’认证（SSH-2）”的勾是否有去掉!!!!

### 重启ssh服务即可
service sshd restart

###  ssh -i key host :Permission denied (publickey,gssapi-keyex,gssapi-with-mic)
- 用户权限的检查，user,.ssh,authorized_keys, 的权限为  700，700，600 。如果大于该权限有可能会出现如上的错误


### Reference Link
- https://www.cnblogs.com/chenfangzhi/p/10926641.html