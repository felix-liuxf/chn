### 查看数据库信息 
- sqlplus / as sysdba
- show con_name
- show pdbs
- SELECT directory_name, directory_path FROM dba_directories


### 查询表空间
- select tablespace_name,file_id,file_name,round(bytes/(1024*1024),0) total_space from dba_data_files;
- select tablespace_name,file_id,round(bytes/(1024*1024),0) total_space from dba_data_files;
- select tablespace_name,file_name,round(bytes/(1024*1024),0) total_space from dba_data_files;
- 查询scott用户默认表空间，默认临时表空间
>select username,default_tablespace,temporary_tablespace from dba_users where username='SCOTT';
- 查询scott用户下所有表使用的表空间
>select owner,table_name,tablespace_name from dba_tables where owner='SCOTT';
- 查询所有表空间剩余空间大小
```
SELECT TABLESPACE_NAME,
       ROUND(SUM(BYTES) / (1024 * 1024), 2) "空闲空间(M)",
       ROUND(MAX(BYTES) / (1024 * 1024), 2) "最大块(M)"
FROM SYS.DBA_FREE_SPACE
GROUP BY TABLESPACE_NAME
```
### 增加表空间大小的方式
```
--第一种：格式化数据文件初始大小并设置自增长到最大值
create tablespace d_test1  datafile '/test1_data/datafile01.dbf' size 10m autoextend on next 5m maxsize 100m;
 
--第二种：格式化数据文件初始大小不设置自增长，当然也就没有最大值
alter tablespace d_test1 add datafile '/test1_data/datafile02.dbf' size 10m;
```
### 新建表空间
- create tablespace SDATA datafile '+DATA/DB1205_BOM1GJ/98F2BF3D2E590C53E0530300000AA88C/DATAFILE/SDATA.dbf' size 1000G ;
- create BIGFILE  tablespace SDATA datafile 'SDATA.dbf' size 100G REUSE AUTOEXTEND ON NEXT 5G MAXSIZE 1500G;

- create temporary tablespace SDATATemp tempfile 'SDATAtemp01.dbf'  size 10G autoextend on next 2G maxsize 20G extent management local  ;
- create BIGFILE tablespace SINDEX datafile 'SINDEX.dbf' size 100G autoextend ON NEXT 5G MAXSIZE 1500G;
- create BIGFILE  tablespace INFO_USER datafile 'INFO_USER.dbf' size 100G AUTOEXTEND ON NEXT 5G MAXSIZE 1500G;

### 删除表空间
- DROP TABLESPACE SINDEX INCLUDING CONTENTS AND DATAFILES;
### 新建用户
- create user siebel identified by siebel default tablespace SDATA temporary tablespace SDATATemp;
- grant connect, resource to siebel;
- grant dba to siebel;

- create user INFO_USER identified by INFO_USER default tablespace INFO_USER temporary tablespace SDATATemp;
- grant connect, resource to INFO_USER;
- grant dba to INFO_USER;
- grant execute on sys.dbms_stats to INFO_USER;

### 删除用户
- drop user siebel;
- drop user siebel cascade;
### 新建一个role
- create role SSE_ROLE;
- create role SREAD_ROLE;
- create role DONGTX;
- grant connect, resource to SSE_ROLE;
### 删除一个role
- drop role SSE_ROLE;

### 查询所有schema
- select username from sys.dba_users
- select table_name from sys.dba_tables where owner='schema名'

### 查询用户的默认表空间
- select username,DEFAULT_TABLESPACE from dba_users where username='INFO_USER';
### 修改用户默认的表空间
- alter user INFO_USER default tablespace INFO_USER;
### 通过指定表空间查询所属的表名
- Select Table_Name, Tablespace_Name From Dba_Tables Where Tablespace_Name = 'USERS';
### 通过指定表空间查询所属表的占用空间
```
select segment_name, bytes/1024||'KB' "占用空间"
from user_segments 
where segment_type='TABLE' and tablespace_name='USERS' order by segment_name asc
```

### impdp examples
- CREATE OR REPLACE directory DATA_PUMP_DIR AS '/u01/expdpdata';
- CREATE DIRECTORY DATA_PUMP_DIR AS '/u01/expdpdata';
- impdp siebel/siebel TABLES=SIEBEL.S_AUDIT_READ DUMPFILE=DATA_PUMP_DIR:S_AUDIT_READ.dmp

### imp examples
- imp system/HaierHaier__123@140.238.224.190/siebel18c.haier.com fromuser=INFO_USER touser=INFO_USER file= info_user.dmp log=imp_info_user.log

- imp siebel/siebel@10.0.0.23/siebel18c.subnet.vcn.oraclevcn.com recordlength=65535 buffer=104857600 file=db1100.dmp fromuser=siebel touser=siebel log=imp-1100.log

### 批量删除表 drop Table
```
declare

begin
  for vcur in (select t.TABLE_NAME
                 from user_tables t
                where t.TABLE_NAME like '%') loop
    execute immediate 'drop table '||vcur.TABLE_NAME;
  end loop;
end;
```

### ERROR IMP-00003: ORACLE error 942 encountered
- 检查一下EXP IMP的版本是否一致兼容。包括，源数据库版本，目标数据库版本，导出导入工具版本
- 正常情况下dbms_stats的权限是通过角色赋予用户的, 在procedure中使用的对象必须显示赋权.


### Reference Link
- [impdp examples](https://docs.oracle.com/database/121/SUTIL/GUID-5404703A-05B6-4E76-B58F-C52AB37BFFAF.htm#SUTIL954)
- https://oracle-base.com/articles/10g/oracle-data-pump-10g
- https://docs.oracle.com/database/121/SQLRF/statements_7003.htm