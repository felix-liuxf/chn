
### 安装Oracle instant client
- https://oracle-base.com/articles/misc/oracle-instant-client-installation#yum
- https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html
```
# (Optional) Get the latest repository info.
cd /etc/yum.repos.d
rm -f public-yum-ol7.repo
wget https://yum.oracle.com/public-yum-ol7.repo

# disable gpgcheck
%s/gpgcheck=1/gpgcheck=0/g

# Enable the instant client repository.
yum install -y yum-utils
yum-config-manager --enable ol7_oracle_instantclient

# (Optional) Check what packages are available.
yum list oracle-instantclient*

# Install basic and sqlplus.
yum install -y oracle-instantclient18.3-basic oracle-instantclient18.3-sqlplus
yum install oracle-instantclient18.3-sqlplus

配置环境变量：
export ORACLE_HOME=/usr/lib/oracle/18.3/client64
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
PATH=$PATH:$HOME/.local/bin:$HOME/bin:/$ORACLE_HOME/bin

instant client tools provides exp / imp utilities since v12.2.0.1.0. Unrestricted download is available:

https://www.oracle.com/technetwork/database/database-technologies/instant-client/downloads/index.html

https://serverfault.com/questions/334493/how-to-install-oracles-exp-imp-binaries

```
### Oracle Datadase Server 安装 创建用户及用户组
```
groupadd oinstall #创建oinstall
groupadd dba # 创建dba组
useradd -g oinstall -G dba oracle #创建oracle用
```
### 创建目录
```
mkdir -p /u01/app/oracle
chown -R oracle:oinstall /u01/app/oracle
chmod -R 775 /u01/app/oracle
```

### 安装依赖的类库
- yum install oracle-rdbms-server-12cR1-preinstall

### 配置内核参数/etc/sysctl.conf
```
添加
oracle soft nproc 2047
oracle hard nproc 16384
oracle soft nofile 1024
oracle hard nofile 65536
oracle soft stack 10240
```
### 开始安装

- runInstaller -silent -responseFile /home/oracle/etc/db_install.rsp
- [db_install.rsp](https://raw.githubusercontent.com/felix0102/chn/master/oracle/db_install.rsp)
### root进行相关配置
As a root user, execute the following script(s):
1. /u01/app/oracle/oraInventory/orainstRoot.sh
2. /u01/app/oracle/product/12.1.0/db_1/root.sh

### 配置启动监听
- /u01/app/oracle/product/12.1.0/db_1/bin/netca -silent -responseFile /home/oracle/netca.rsp
- lsnrctl start
- lsnrctl status
- lsnrctl reload 重新启动监听

### 创建数据库实例
- dbca -silent -responseFile /home/oracle/dbca.rsp


```
INFO: Adding ExitStatus VAR_VALIDATION_FAILURE to the exit status set
WARNING: A log of this session is currently saved as: /tmp/OraInstall2013-11-15_02-29-20PM/installActions2013-11-15_02-29-20PM.log. Oracle recommends that if you want to keep this log, you should move it from the temporary location.
INFO: Finding the most appropriate exit status for the current application
INFO: Exit Status is -2
INFO: Shutdown Oracle Database 12c Release 1 Installer
INFO: Unloading Setup Driver
```
- Because DECLINE_SECURITY_UPDATES=false has been set before, so here he quit, failed to complete the installation

### Reference Link
- [oracle12c installation silent](https://www.jianshu.com/p/309bb3504285)
