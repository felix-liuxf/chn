### 查看session：
>select * from v$session where username is not null

>select username,count(username) from v$session where username is not null group by username
### 当前连接数：
>select count(*) from v$process
### 查看数据库允许的最大连接数：
>select value from v$parameter where name = 'processes'
### 查看当前并发连接数 
>Select count(*) from v$session where status='ACTIVE'　

### 获得需要kill session的信息(使用V$SESSION 和 GV$SESSION视图)
```
SET LINESIZE 180
COLUMN spid FORMAT A10
COLUMN username FORMAT A10
COLUMN program FORMAT A40;


SELECT s.inst_id,
s.sid,
s.serial#,
p.spid,
s.username,
s.program,
s.paddr,
s.STATUS FROM gv$session s
JOIN gv$process p ON p.addr = s.paddr AND p.inst_id = s.inst_id and s.username='FELIX'
WHERE s.type != 'BACKGROUND';
```


Select count(*) from v$session where status='ACTIVE'　


begin
    rdsadmin.rdsadmin_util.kill(
        sid    => 748, 
        serial => 30576);
end;
/


SELECT s.inst_id,
       s.sid,
       s.serial#,
       --s.sql_id,
       p.spid,
       s.username,
       s.program
FROM   gv$session s
       JOIN gv$process p ON p.addr = s.paddr AND p.inst_id = s.inst_id
WHERE  s.type != 'BACKGROUND';





### 从V$SQLAREA中查询最占用资源的查询

select b.username username,a.disk_reads reads,
a.executions exec,a.disk_reads/decode(a.executions,0,1,a.executions) rds_exec_ratio,
a.sql_text Statement
from v$sqlarea a,dba_users b
where a.parsing_user_id=b.user_id
and a.disk_reads > 100000
order by a.disk_reads desc;

用buffer_gets列来替换disk_reads列可以得到占用最多内存的sql语句的相关信息。
V$SQL是内存共享SQL区域中已经解析的SQL语句。
### 列出使用频率最高的5个查询

select sql_text,executions
from (select sql_text,executions,
rank() over
(order by executions desc) exec_rank
from v$sql)
where exec_rank <=5;
### 消耗磁盘读取最多的sql top5

select disk_reads,sql_text
from (select sql_text,disk_reads,
dense_rank() over
(order by disk_reads desc) disk_reads_rank
from v$sql)
where disk_reads_rank <=5;

### 找出需要大量缓冲读取（逻辑读）操作的查询

select buffer_gets,sql_text
from (select sql_text,buffer_gets,
dense_rank() over
(order by buffer_gets desc) buffer_gets_rank
from v$sql)
where buffer_gets_rank<=5;
###  磁盘读取最多的SQL
```
select disk_reads,sql_text
from (select sql_text,disk_reads,
dense_rank() over
(order by disk_reads desc) disk_reads_rank
from v$sql)
where disk_reads_rank <=5;
```

### 回话内存占用情况
```
SELECT server "连接类型",
       s.username,
       OSUSEr,
       NAME,
       VALUE/1024/1024 "占用内存MB",
       s.SID "会话ID",
       s.serial#,
       spid "操作系统进程ID",
       p.PGA_USED_MEM,
       p.PGA_ALLOC_MEM,
       p.PGA_FREEABLE_MEM,
       p.PGA_MAX_MEM
  FROM v$session s, v$sesstat st, v$statname sn, v$process p
 WHERE st.SID = s.SID
   AND st.statistic# = sn.statistic#
   AND sn.NAME LIKE 'session pga memory'
   AND p.addr = s.paddr
 ORDER BY VALUE DESC

```




### 时间占用最多的查询
```
SELECT S.SQL_TEXT,
       S.SQL_FULLTEXT,
       S.SQL_ID,
       ROUND(ELAPSED_TIME / 1000000 / (CASE
               WHEN (EXECUTIONS = 0 OR NVL(EXECUTIONS, 1) = 1) THEN
                1
               ELSE
                EXECUTIONS
             END),
             2) "执行时间'S'",
       S.EXECUTIONS "执行次数",
       S.OPTIMIZER_COST "COST",
       S.SORTS,
       S.MODULE, --连接模式（JDBC THIN CLIENT：程序）
       -- S.LOCKED_TOTAL,
       --S.PHYSICAL_READ_BYTES "物理读",
       -- S.PHYSICAL_READ_REQUESTS "物理读请求",
       --S.PHYSICAL_WRITE_REQUESTS "物理写",
       -- S.PHYSICAL_WRITE_BYTES "物理写请求",
       S.ROWS_PROCESSED      "返回行数",
       S.DISK_READS          "磁盘读",
       S.DIRECT_WRITES       "直接路径写",
       S.PARSING_SCHEMA_NAME,
       S.LAST_ACTIVE_TIME
  FROM GV$SQLAREA S
 WHERE ROUND(ELAPSED_TIME / 1000000 / (CASE
               WHEN (EXECUTIONS = 0 OR NVL(EXECUTIONS, 1) = 1) THEN
                1
               ELSE
                EXECUTIONS
             END),
             2) > 5 --100 0000微秒=1S
   AND S.PARSING_SCHEMA_NAME = USER
   AND TO_CHAR(S.LAST_LOAD_TIME, 'YYYY-MM-DD') =
       TO_CHAR(SYSDATE, 'YYYY-MM-DD')
   AND S.COMMAND_TYPE IN (2, 3, 5, 6, 189)
 ORDER BY "执行时间'S'" DESC;
 ```
