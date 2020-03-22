1.用oracle用户登录
如果要再次安装， 最好先做一些备份工作。
包括用户的登录脚本，数据库自动启动关闭的脚本，和Listener自动启动的脚本。
要是有可能连创建数据库的脚本也保存下来

2.使用SQL*PLUS停止数据库
[oracle@ora920 oracle]$ sqlplus /nolog
SQL> connect / as sysdba
SQL> shutdown [immediate]
SQL> exit

3.停止Listener
[oracle@ora920 oracle]$ lsnrctl stop

4.停止HTTP服务
[oracle@ora920 oracle]$ $ORACLE_HOME/Apache/Apache/bin/apachectl stop

5.用su或者重新登录到root(如想重新安装可以保留oracle用户，省得输入环境变量了)

6.将安装目录删除
[root@ora920 /root]# rm -rf /opt/oracle/

7.将/usr/bin下的文件删除
[root@ora920 /root]# rm /usr/bin/dbhome
[root@ora920 /root]# rm /usr/bin/oraenv
[root@ora920 /root]# rm /usr/bin/coraenv

8.将/etc/oratab删除
[root@ora920 /root]# rm /etc/oratab

9.将/etc/oraInst.loc删除
[root@ora920 /root]# rm /etc/oraInst.loc

10.将oracle用户删除(若要重新安装,可以不删除)
[root@ora920 /root]# userdel ?r oracle

11.将用户组删除(若要重新安装,可以不删除)
[root@ora920 /root]# groupdel oinstall
[root@ora920 /root]# groupdel dba

12.将启动服务删除
[root@ora920 /root]# chkconfig --del dbora