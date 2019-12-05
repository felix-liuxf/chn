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

### 数据库字符集 国家字符集的不同:（AL16UTF16与UTF-8）
```
服务器端：（oracle服务器端字符集）
数据库字符集在创建数据库时指定，在创建后通常不能更改。在创建数据库时，可以指定字符集(CHARACTER SET)和国家字符集(NATIONAL CHARACTER SET)。
1. 字符集:
    (1)用来存储CHAR, VARCHAR2, CLOB, LONG等类型数据
    (2)用来标示诸如表名、列名以及PL/SQL变量等
    (3)用来存储SQL和PL/SQL程序单元等
2. 国家字符集：
    (1)用以存储NCHAR, NVARCHAR2, NCLOB等类型数据
    (2)国家字符集实质上是为oracle选择的附加字符集，主要作用是为了增强oracle的字符处理能力，因为NCHAR数据类型可以提供对亚洲使用定长多字节编码的支持，而数据库字符集则不能。国家字符集在oracle9i中进行了重新定义，只能在unicode编码中的AF16UTF16和UTF8中选择，默认值是AF16UTF16
3. 查询字符集参数：
    可以查询以下数据字典或视图查看字符集设置情况
    nls_database_parameters、props$、v$nls_parameters
    查询结果中NLS_CHARACTERSET表示字符集，NLS_NCHAR_CHARACTERSET表示国家字符集
4. 修改数据库字符集：
    按照上文所说，数据库字符集在创建后原则上不能更改。如果需要修改字符集，通常需要导出数据库数据，重建数据库，再导入数据库数据的方式来转换，或通过ALTER DATABASE CHARACTER SET语句修改字符集，但创建数据库后修改字符集是有限制的，只有新的字符集是当前字符集的超集时才能修改数据库字符集，例如UTF8是US7ASCII的超集，修改数据库字符集可使用ALTER

客户端：（NLS_LANG参数）
客户端字符集定义了客户端字符数据的编码方式，任何发自或发往客户端的字符数据均使用客户端定义的字符集编码,客户端可以看作是能与数据库直接连接的各种应用，例如sqlplus,exp/imp等。客户端字符集是通过设置NLS_LANG参数来设定的。

国家字符集的不同:（AL16UTF16与UTF-8）
1. AL16UTF16 和 UTF8 这两种选择都适用于国家字符集
2. AL16UFT16 是宽度固定的双字节 Unicode 字符集；UTF8 是宽度可变的、一至三个字节的 Unicode 字符集
3. 欧洲字符在 UTF8 中按一至两个字节存储，而在 AL16UTF16 中按两个字节存储，相比之下，UTF8可以节省空间；亚洲字符在 UTF8 中按三个字节存储，这样，所需的空间比在 AL16UTF16 中要多
4. AL16UTF16 是宽度固定的编码，因此在执行速度上要比宽度可变的 UTF8 快
```
