### 修改用户的主目录
```
修改oracle用户的主目录到/u01/app/oracle
id oracle
uid=501(oracle) gid=501(oinstall) groups=501(oinstall)
usermod -d /u01/app/oracle -u 501 oracle
```
