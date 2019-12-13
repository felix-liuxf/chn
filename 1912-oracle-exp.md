### 查看数据库的字符集

 select * from nls_database_parameters;
 
### exp 设置oracle客户端字符集
export NLS_LANG=AMERICAN_AMERICA.AL32UTF8

### oracle查看数据库文件大小 

- 保留两位小数以GB为单位显示数据文件大小
- SELECT ROUND(SUM(BYTES)/1024/1024/1024,2)||'GB' FROM DBA_DATA_FILES;
>ROUND(SUM(BYTES)/1024/1024/1024,2)||'GB'
>------------------------------------------
>975.08GB

### 按Schema用户查看数据库大小
- select owner,sum(bytes)/1024/1024||'M' from DBA_SEGMENTS group by owner

OWNER | 数据量M
------------ | -------------
SIEBEL | 705091.25M
OUTLN |.5625M
CTXSYS |3.9375M
INFO_USER |168854.625M
SPIUSERCREATE |.375M
SYSTEM |32.1875M
RDSADMIN |.25M
DBSNMP |1.25M
GSMADMIN_INTERNAL |1.375M
TRANSMASTER |.375M
XDB |63M
SYS | 44248.75M



### 以MB为单位表空间分组显示数据文件大小：

- SELECT TABLESPACE_NAME,SUM(BYTES)/1024/1024 AS MB FROM DBA_DATA_FILES GROUP BY TABLESPACE_NAME;

TABLESPACE_NAME 	|	       MB
------------------------------ | ----------
SINDEX			|	193124.75
TAB_GGS 			 |     100
SYSAUX	|			6169.1875
SDATA				|   532584
PATROL			|	      100
UNDOTBS1		|	      100
USERS			|	  3082.75
INFO_USER			|   170392
SYSTEM				  |    700
RDSADMIN			|	7
UNDO_T1 			  |  92020
UNDOTBS2			   |   100

### linux 查询网络流量是多少

- sar -n DEV 5 10

### 查询数据库的分区表
```
如果查询当前用户下得分区表：
select * from user_tables where partitioned='YES'
如果要查询整个数据库中的分区表：
select * from dba_tables where partitioned='YES'
如果要查询某个用户下得分区表：
select * from dba_tables where partitioned='YES' and owner='ABCDEFG'
其中ABCDEFG为用户名
```


### exp 按用户Schema导出。
exp transmaster/Ora09haier24@13.228.121.188/ORACLE1 owner=SIEBEL direct=y recordlength=65535 buffer=104857600 file=db.dmp log=exp.log feedback=10000 
### exp 按表导出导出。
exp transmaster/Ora09haier24@13.228.121.188/ORACLE1  direct=y recordlength=65535 buffer=104857600 file=db.dmp log=exp.log feedback=10000 tables = 'SIEBEL.S_APPL_CON';
exp transmaster/Ora09haier24@13.228.121.188/ORACLE1  direct=y recordlength=65535 buffer=104857600 file=db.dmp log=exp.log feedback=10000 tables = 'SIEBEL.S_APPL_CON,SYSTEM.TABLE2';



### 查询表的大小
- SELECT segment_name AS TABLENAME,round(BYTES/1024/1024,2)  FROM user_segments WHERE segment_name='SIEBEL.S_ORG_EXT_LSX';
SELECT segment_name AS TABLENAME,round(BYTES/1024/1024,2)  FROM SIEBEL.user_segments;

另一种表实际使用的空间。这样查询：

analyze table SIEBEL.S_ORG_EXT_LSX compute statistics; select num_rows * avg_row_len from user_tables where table_name = 'SIEBEL.S_ORG_EXT_LSX';

显示数据库中临时文件的大小：
analyze table SIEBEL.S_ORG_EXT_LSX compute statistics;

select num_rows * avg_row_len from user_tables where table_name = 'SIEBEL.S_ORG_EXT_LSX';
```
SELECT SUM(BYTES)/1024/1024/1024 AS GB FROM DBA_TEMP_FILES;
显示数据库中日志文件的大小：

SELECT SUM(BYTES)/1024/1024/1024 AS GB FROM V$LOG;
显示数据库中数据文件、临时文件、日志文件的总大小：
SELECT SUM(GB) AS GB
FROM(
     SELECT SUM(BYTES)/1024/1024/1024 AS GB 
     FROM DBA_DATA_FILES
     UNION ALL
     SELECT SUM(BYTES)/1024/1024/1024
     FROM DBA_TEMP_FILES
     UNION ALL
     SELECT SUM(BYTES)/1024/1024/1024
     FROM V$LOG
     );
     
     
     1、查看所有表空间及表空间大小：
select tablespace_name ,sum(bytes)/1024/1024 as MB　from dba_data_files group by tablespace_name;

2、查看所有表空间对应的数据文件：
select tablespace_name,file_name from dba_data_files;

3、修改数据文件大小：
alter database datafile 'H:\ORACLE\PRODUCT\10.1.0\ORADATA\ORACLE\USERS01.DBF' RESIZE 10240M;
```     

select * from user_tables t where t.NUM_ROWS is not null  order by t.NUM_ROWS  desc




### 设置exp 文件大小
$ expdp user/pwd directory=dump_file dumpfile=expdp_20190416_%U.dmp logfile=expdp_20100820.log filesize=500M parallel=4

exp userid=scott/tiger file=/tmp/test1,/tmp/test2,/tmp/test3,/tmp/test4,/tmp/test5 filesize=1024000 log=test.log
imp userid=lhr/lhr FILE=/tmp/test1,/tmp/test2,/tmp/test3,/tmp/test4,/tmp/test5 LOG=imp_emp.log FROMUSER=scott TOUSER=lhr TABLES=emp
--数据泵示例
expdp   system/lhr   SCHEMAS=scott     DIRECTORY=DATA_PUMP_DIR      DUMPFILE=DATA_PUMP_DIR:expdp_20190416_%U.dmp      FILESIZE=1024000 
impdp lhr/lhr    SCHEMAS=scott     DIRECTORY=DATA_PUMP_DIR     DUMPFILE=DATA_PUMP_DIR:expdp_20190416_%U.dmp


一、 导出/导入（Export/Import）  

    利用Export可将数据从数据库中提取出来，利用Import则可将提取出来的数据送回Oracle数据库中去。  
    1. 简单导出数据（Export）和导入数据（Import） 
    Oracle支持三种类型的输出：  
    （1）表方式（T方式），将指定表的数据导出。 
    （2）用户方式（U方式），将指定用户的所有对象及数据导出。 
    （3）全库方式（Full方式），将数据库中的所有对象导出。 
    数据导出（Import）的过程是数据导入（Export）的逆过程，它们的数据流向不同。  

    2. 增量导出/导入  

    增量导出是一种常用的数据备份方法，它只能对整个数据库来实施，并且必须作为SYSTEM来导出。在进行此种导出时，系统不要求回答任何问题。导出文件名缺省为export.dmp，如果不希望自己的输出文件定名为export.dmp，必须在命令行中指出要用的文件名。  

    增量导出包括三个类型：  

    （1）“完全”增量导出（Complete）  

    即备份整个数据库，比如：  

    ＄exp system/manager inctype=complete file=990702.dmp  

    （2） “增量型”增量导出  

    备份上一次备份后改变的数据。比如：  

    ＄exp system/manager inctype=incremental file=990702.dmp  

    （3） “累计型”增量导出（Cumulative）  

    累计型导出方式只是导出自上次“完全” 导出之后数据库中变化了的信息。比如：  

    ＄exp system/manager inctype=cumulative file=990702.dmp  

    数据库管理员可以排定一个备份日程表，用数据导出的三个不同方式合理高效地完成。  

    比如数据库的备份任务可作如下安排：  

    星期一：完全导出（A）  

    星期二：增量导出（B）  

    星期三：增量导出（C）  

    星期四：增量导出（D）  

    星期五：累计导出（E）  

    星期六：增量导出（F）  

    星期日：增量导出（G）  

    如果在星期日，数据库遭到意外破坏，数据库管理员可按以下步骤来恢复数据库：  

    第一步：用命令CREATE DATABASE重新生成数据库结构；  

    第二步：创建一个足够大的附加回段。  

    第三步：完全增量导入A：  

    ＄imp system./manager inctype= RECTORE FULL=Y FILE=A  

    第四步：累计增量导入E：  

    ＄imp system/manager inctype= RECTORE FULL=Y FILE =E  

    第五步：最近增量导入F：  

    ＄imp system/manager inctype=RESTORE FULL=Y FILE=F  

    二、 冷备份  

    冷备份发生在数据库已经正常关闭的情况下，当正常关闭时会提供给我们一个完整的数据库。冷备份是将关键性文件拷贝到另外位置的一种说法。对于备份Oracle信息而言，冷备份是最快和最安全的方法。冷备份的优点是：  

    1．是非常快速的备份方法（只需拷贝文件）  

    2．容易归档（简单拷贝即可）  

    3．容易恢复到某个时间点上（只需将文件再拷贝回去）  

    4．能与归档方法相结合，作数据库“最新状态”的恢复。  

    5．低度维护，高度安全。  

    但冷备份也有如下不足：  

    1．单独使用时，只能提供到“某一时间点上”的恢复。  

    2．在实施备份的全过程中，数据库必须要作备份而不能作其它工作。也就是说，在冷备份过程中，数据库必须是关闭状态。  

    3．若磁盘空间有限，只能拷贝到磁带等其它外部存储设备上，速度会很慢。  

    4．不能按表或按用户恢复。  

    如果可能的话（主要看效率），应将信息备份到磁盘上，然后启动数据库（使用户可以工作）并将所备份的信息拷贝到磁带上（拷贝的同时，数据库也可以工作）。 冷备份中必须拷贝的文件包括：  

    1．所有数据文件  

    2．所有控制文件  

    3．所有联机REDO LOG文件  

    4．Init.ora文件（可选）。  

    值得注意的是冷备份必须在数据库关闭的情况下进行，当数据库处于打开状态时，执行数据库文件系统备份是无效的  

    下面是做冷备份的完整例子：  

    （1） 关闭数据库 ＄sqldba lmode=y  

    SQLDBA >connect internal;  

    SQLDBA >shutdown normal;  

    （2） 用拷贝命令备份全部的时间文件、重做日志文件、控制文件、初始化参数文件  

    SQLDBA >! cp  

    （3） 重启Oracle数据库  

    ＄sqldba lmode=y  

    SQLDBA >connect internal;  

    SQLDBA >startup;  

    三、 热备份  

    热备份是在数据库运行的情况下，采用archivelog mode方式备份数据的方法。所以，如果你有昨天夜里的一个冷备份而且又有今天的热备份文件，在发生问题时，就可以利用这些资料恢复更多的信息。热备份要求数据库在Archivelog方式下操作，并需要大量的档案空间。一旦数据库运行在archivelog状态下，就可以做备份了。热备份的命令文件由三部分组成：  

    1．数据文件一个表空间一个表空间地备份。  

    （1）设置表空间为备份状态  

    （2）备份表空间的数据文件  

    （3）恢复表空间为正常状态  

    2．备份归档log文件。  

    （1）临时停止归档进程  

    （2）log下那些在archive redo log目标目录中的文件  

    （3）重新启动archive进程  

    （4）备份归档的redo log 文件  

    3．用alter database backup controlfile命令来备份拷贝文件  

    热备份的优点是：  

    1．可在表空间或数据文件级备份，备份时间短。  

    2．备份时数据库仍可使用。  

    3．可达到秒级恢复（恢复到某一时间点上）。  

    4．可对几乎所有数据库实体作恢复。  

    5．恢复是快速的，在大多数情况下在数据库仍工作时恢复。  

    热备份的不足是：  

    1．不能出错，否则后果严重。  

    2．若热备份不成功，所得结果不可用于时间点的恢复。  

    3．因难于维护，所以要特别仔细小心，不允许“以失败而告终”。 
    
    
    
    
    ### sqlplus将查询结果重定向到文件，不输出到屏幕
    ```
--每行的字符数目
set linesize 8000
--该参数设置每页输出的行数。n=0表示不产生新页
set pagesize 0
--显示和拷贝long类型值的最大宽度的设置，最大值2G
set long 2000000000
--sqlplus检索long类型值的增量大小.由于内存的限制 可按增量检索
--一项目当时plsql和sqldeveloper都有明显的网络延迟问题，sqlplus缺省没有问题，设置此参数后也能够使问题重现
set longchunksize 9000000
--列的设置
--col username format a4 
--col a format 999,999,999
--各列的标题（包括文字和下划线）在结果报表上显示。
set heading on 
--查询结束时，给出查询结果的记录数信息。禁止显示最后一行的计数反馈信息
set feedback off 
--执行命令文件时，命令本身是否显示在屏幕上
set echo off
--控制由文件执行命令所产生的输出的显示
set termout off
--清空多余的空格，如：linesize过长
set trimout on
set trimspool on
set timing on

--生产数据命令
spool result.txt;
select * from nls_database_parameters;
spool off;
    ```
    
SELECT s.username, t.sid,s.serial#, SUM(VALUE/100) as "cpu usage (seconds)" FROM v$session s, v$sesstat t,  v$statname n WHERE t.STATISTIC# = n.STATISTIC# AND NAME like '%CPU used by this session%' AND t.SID = s.SID AND s.status='ACTIVE' AND s.username is not null GROUP BY username,t.sid,s.serial#    
    
### Reference Link
- http://blog.itpub.net/117319/viewspace-1410931/
- https://blog.csdn.net/haiross/article/details/27579945
- http://www.oracle-wiki.net/startsql#toc16
- 数据库字符集 http://blog.itpub.net/26736162/viewspace-2126759/

