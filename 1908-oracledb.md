### SYS SYSTEM 用户区别

- sys:这个账户相当于SQL server中的sa账户，是个超级账户，拥有的权限最大，可以完成数据库的所有管理任务
- system：没有sys的权限大，通常用来创建一些用于查看管理信息的表或视图。
- sys和system在登录oracle工具时，sys只能以系统管理员（sysdba）或系统操作员（sysoper）的权限登录，而system可以直接登录（normal）
- sys用户 所有oracle的数据字典的基表和视图都存放在sys用户中，这些基表和视图对于oracle的运行是至关重要的，由数据库自己维护，任何用户都不能手动更改。sys用户拥有dba，sysdba，sysoper等角色或权限，是oracle权限最高的用户。
- system 用户用于存放次一级的内部数据，如oracle的一些特性或工具的管理信息。system用户拥有普通dba角色权限。


### 修改SYSTEM 用户密码
- sqlplus / as sysdba
- alter user  sys identified by 123456;

### 常用SQL
查看哪些用户被授予了DBA权限
>select * from dba_role_privs where granted_role='DBA';

回收权限:
>revoke dba from xxx;


### Oracle Database Upgrade in OCI (e.g. 12.X to 18c)
```
Here some general advises:
=> 12.X only allows CDB in the cloud. Hence upgrading is in essence always a “migration” to a new database, as you need to convert 11.2 to a 12.x CDB. You can use the transportable tablespace way to do this (which in essence can make use of the local files, so you don’t really need to move them).
=> VMs only allow 1 DB home. So while inplace upgrade is possible, out of place is not. So general suggestion here would also be to spin up a new system and then to upgrade
=> GI stack is also relevant. So in often cases you need to upgrade the GI first, before you can upgrade your database. The GI upgrade however is not yet available. So if you deployed your system with 12.1 stack, you need to spin up a DB System with the 18c stack to be able to upgrade. (We are working on a solution).
=> A console upgrade button is not any time near. You can however use dbcli on the Box to do the upgrade.
=> Exadata DB System already has an upgrade option documented. There this is also manually as of today. But Exadata DB System already has a GI upgrade available.
=> All general upgrade mechanism exist. E.g . export/import will always be there, as well as rman backup/restore to a new system and run cat upgrade there. In the following table I just list the things I would suggest.
=> Minimal Downtime Upgrades via. Transient Logical Standby can also be done, however will definitely be manual. And as written above (due to not support CDB requirement) not between 11.2 and 18c.
=> 18c DB Systems only support 18c databases as of today. So you definitely have to spin up a new system to upgrade to 18c. 18c direct upgrade path are in the works.
=> If upgrading via. dbcli today it will bring the console out of SYNC. We are working on that issue, but as of now you need a ticket for this. Therefore I recommend to use PDB Plugout/Plugin to upgrade a PDB at this point in time.

There is a nice table, which I unfortunately cannot paste here :(
```
