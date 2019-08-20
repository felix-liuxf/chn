### SYS SYSTEM 用户区别

- sys:这个账户相当于SQL server中的sa账户，是个超级账户，拥有的权限最大，可以完成数据库的所有管理任务
- system：没有sys的权限大，通常用来创建一些用于查看管理信息的表或视图。
- sys和system在登录oracle工具时，sys只能以系统管理员（sysdba）或系统操作员（sysoper）的权限登录，而system可以直接登录（normal）
- sys用户 所有oracle的数据字典的基表和视图都存放在sys用户中，这些基表和视图对于oracle的运行是至关重要的，由数据库自己维护，任何用户都不能手动更改。sys用户拥有dba，sysdba，sysoper等角色或权限，是oracle权限最高的用户。
- system 用户用于存放次一级的内部数据，如oracle的一些特性或工具的管理信息。system用户拥有普通dba角色权限。


### 修改SYSTEM 用户密码
- sqlplus / as sysdba
- alter user  sys identified by 123456;
