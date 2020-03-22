### expdp 导出

### 查询DATA_PUMP_DIR
- select * from dba_directories;
- /rdsdbdata/datapump

CREATE DIRECTORY dmpdir AS '/rdsdbdata/datapump'

CREATE DIRECTORY dmpdir AS '/u01/dmpdir'

DPUMP_DIR1
/rdsdbdata/userdirs/01

### 检查是否有写的权限
```
DECLARE
filehandle utl_file.file_type;begin
filehandle:= utl_file.fopen('dmpdir','test.txt','w');
utl_file.put_line(filehandle,'test 1 write one.');
utl_file.put_line(filehandle,'你好!');
utl_file.fclose(filehandle);
end;
```
### 查询当前运行的job
- select job_name, owner_name,state from dba_datapump_jobs;

### 列出 DATA_PUMP_DIR 中的文件。
- select * from table(RDSADMIN.RDS_FILE_UTIL.LISTDIR('DATA_PUMP_DIR')) order by mtime;
### 导出Schema 
```
DECLARE
hdnl NUMBER;
BEGIN
hdnl := DBMS_DATAPUMP.OPEN( operation => 'EXPORT', job_mode => 'SCHEMA', job_name=>'felixExpdp-schema-siebel');
DBMS_DATAPUMP.ADD_FILE( handle => hdnl, filename => 'schema-siebel.dmp', directory => 'DATA_PUMP_DIR', filetype => dbms_datapump.ku$_file_type_dump_file);
DBMS_DATAPUMP.ADD_FILE( handle => hdnl, filename => 'schema-siebel.log', directory => 'DATA_PUMP_DIR', filetype => dbms_datapump.ku$_file_type_log_file);
DBMS_DATAPUMP.METADATA_FILTER(hdnl,'SCHEMA_EXPR','IN (''SIEBEL'')');
DBMS_DATAPUMP.SET_PARALLEL(hdnl,6);
DBMS_DATAPUMP.START_JOB(hdnl);
END;
/ 
```
### 导出特定的表
```
导出特定表table(表模式)

	DECLARE
	   l_dp_handle        NUMBER;
	   l_last_job_state   VARCHAR2 (30) := 'UNDEFINED';
	   l_job_state        VARCHAR2 (30) := 'UNDEFINED';
	   l_sts              KU$STATUS;
	BEGIN
	   l_dp_handle :=
	      DBMS_DATAPUMP.open (operation     => 'EXPORT'
	                        , job_mode      => 'TABLE'
	                        , remote_link   => NULL
	                        , job_name      => 'JOB_EXP2'
	                        , version       => 'LATEST');
	   DBMS_DATAPUMP.
	    add_file (handle      => l_dp_handle
	            , filename    => 'emp_tbl.dmp'
	            , directory   => 'DB_DUMP_DIR'
	            , filetype    => DBMS_DATAPUMP.KU$FILE_TYPE_DUMP_FILE);
	   DBMS_DATAPUMP.
	    add_file (handle      => l_dp_handle
	            , filename    => 'emp_tbl.log'
	            , directory   => 'DB_DUMP_DIR'
	            , filetype    => DBMS_DATAPUMP.KU$FILE_TYPE_LOG_FILE);
	   -->如果非当前帐户，使用下面的过滤条件，即特定schema下的特定表，如为当前帐户，此过滤条件可省略
	   DBMS_DATAPUMP.
	    metadata_filter (handle   => l_dp_handle
	                   , name     => 'SCHEMA_EXPR'
	                   , VALUE    => 'IN(''SCOTT'')');
	   DBMS_DATAPUMP.
	    metadata_filter (handle   => l_dp_handle
	                   , name     => 'NAME_EXPR'
	                   , VALUE    => 'IN(''EMP'')');
	   DBMS_DATAPUMP.start_job (l_dp_handle);
	   DBMS_DATAPUMP.detach (l_dp_handle);
	END;
```

### 导出SIEBEL.S_AUDIT_ITEM
```
DECLARE
hdnl NUMBER;
BEGIN
hdnl := DBMS_DATAPUMP.OPEN( operation => 'EXPORT', job_mode => 'TABLE', job_name=>'felixExpdp-3');
DBMS_DATAPUMP.ADD_FILE( handle => hdnl, filename => 'S_AUDIT_ITEM-3.dmp', directory => 'DATA_PUMP_DIR', filetype => dbms_datapump.ku$_file_type_dump_file);
DBMS_DATAPUMP.ADD_FILE( handle => hdnl, filename => 'S_AUDIT_ITEM-3.log', directory => 'DATA_PUMP_DIR', filetype => dbms_datapump.ku$_file_type_log_file);
DBMS_DATAPUMP.SET_PARALLEL(hdnl,4);
DBMS_DATAPUMP.METADATA_FILTER(hdnl,'SCHEMA_EXPR','IN(''SIEBEL'')');
DBMS_DATAPUMP.METADATA_FILTER(hdnl,'NAME_EXPR','IN(''S_AUDIT_ITEM'')');
DBMS_DATAPUMP.START_JOB(hdnl);
END;
```
### 查看到expdp导出日志。
- SELECT text FROM table(rdsadmin.rds_file_util.read_text_file('BDUMP','dbtask-1576751562884-132.log'));  


### 将转储文件上传到 Amazon S3 存储桶。
```
SELECT rdsadmin.rdsadmin_s3_tasks.upload_to_s3(
      p_bucket_name    =>  'archivestore1-sa-gsis-aws',       
      p_directory_name =>  'DATA_PUMP_DIR') 
   AS TASK_ID FROM DUAL;            

```
### AWS s3 get objecy
 - aws2 s3api get-object --bucket archivestore1-sa-gsis-aws  --key S_AUDIT_READ.log a.log


### 目录权限错误
- 注意要有该目录，要有权限，不能有重复的文件，比如已经执行过一次了，下一次会出现错误。
- 注意大小写，ORACLE数据库尽量都用大写吧，免得麻烦。
```
ERROR at line 1:
ORA-39001: invalid argument value
ORA-06512: at "SYS.DBMS_SYS_ERROR", line 79
ORA-06512: at "SYS.DBMS_DATAPUMP", line 4932
ORA-06512: at "SYS.DBMS_DATAPUMP", line 5183
ORA-06512: at line 5

```
### 注意事项
- 1、使用schema模式导出时，如果导出的schema为当前schema,则不需要指定schema过滤条件，否则需要对schema进行过滤
- 2、使用table表模式导出时，如果导出的表为当前schema,则不需要指定schema过滤条件，否则需要对schema进行过滤
- 3、对于过滤表上的特定记录可以使用多种SQL表达式，如 LIKE, NOT LIKE,IN, NOT IN, = , != 符号等
- 4、需要注意单引号的使用，尤其是在字符型的数据类型时，两个单引号代表一个引号
- 5、如果在导出时存在同样的dump文件和日志文件时PL/SQL块将执行失败，删除或通过写PL/SQL来判断文件是否存在，如存在是否覆盖等
- 6、如果指定了job_name，则当前job失败之后，再次执行时会碰到job已经存在的提示，建议让系统自动生成job_name简化管理


### Reference Link
- https://docs.aws.amazon.com/zh_cn/AmazonRDS/latest/UserGuide/Oracle.Procedural.Importing.html#Oracle.Procedural.Importing.DataPump.Step7
- https://cloud.tencent.com/developer/article/1184387
- https://www.oracle-scripts.net/cleanup-orphaned-datapump-jobs/
