### 查看SCN
- select dbms_flashback.get_system_change_number from dual;
可以理解，这里返回的SCN，也是目前redo log file最新的SCN纪录。因为commit后的交易才会有SCN，而一旦commit就会立刻写入redo log file中。
```
GET_SYSTEM_CHANGE_NUMBER
------------------------
                15351432
```
- select checkpoint_change# from v$database


- select GROUP#, STATUS, FIRST_CHANGE# from v$log;

### SCN  概念说明
```
透析SCN号

SCN是当Oracle数据库更新后，由DBMS自动维护去累积递增的一个数字。当一笔交易commit时，LGWR会将log buffer写入redo log file，同时也会将该笔交易的SCN同步写入到redo log file内（wait-until-completed）。因此当你commit transaction时，在交易成功的讯息返回之前，LGWR必须先完整的完成上述行为之后，否则你是看不到提交成功的回应讯息。

可以查询目前系统最新的SCN
SQL>select dbms_flashback.get_system_change_number from dual;

可以理解，这里返回的SCN，也是目前redo log file最新的SCN纪录。因为commit后的交易才会有SCN，而一旦commit就会立刻写入redo log file中。

CHECKPOINT和SCN的关联
Checkpoint发生的目的就是要把存储在buffer内的已提交交易写回disk，否则一旦发生crash，需要进行recovery时，就必须花很多时间从redo log file内最后的SCN交易开始进行recovery，这样在商业应用上是很浪费时间和没有效率的。

当commit一笔交易时，只会立刻将redo buffer写入redo log file内，但是并不会马上将该update后的block（dirty block）同步写回disk datafile中，这是为了减少过多disk IO，所以采取batch方式写入。

When a checkpoint occurs. Oracle must update the headers of all datafiles to record the details of the checkpoint.  This is done by the CKPT process.  The CKPT process does not write blocks to disk; DBWn always performs that work.

在shutdown normal or shutdown immediate下，也就是所谓的clean shutdown, checkpoint也会自动触发。当发生checkpoint时，会把SCN写到四个地方去。三个地方在control file 内，一个在datafile hea
```
### Reference Link
- https://blog.csdn.net/weixin_42774383/article/details/97629541