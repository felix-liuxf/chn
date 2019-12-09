### 设置exp 文件大小
$ expdp user/pwd directory=dump_file dumpfile=expdp_20190416_%U.dmp logfile=expdp_20100820.log filesize=500M parallel=4

exp userid=scott/tiger file=/tmp/test1,/tmp/test2,/tmp/test3,/tmp/test4,/tmp/test5 filesize=1024000 log=test.log
imp userid=lhr/lhr FILE=/tmp/test1,/tmp/test2,/tmp/test3,/tmp/test4,/tmp/test5 LOG=imp_emp.log FROMUSER=scott TOUSER=lhr TABLES=emp
--数据泵示例
expdp   system/lhr   SCHEMAS=scott     DIRECTORY=DATA_PUMP_DIR      DUMPFILE=DATA_PUMP_DIR:expdp_20190416_%U.dmp      FILESIZE=1024000 
impdp lhr/lhr    SCHEMAS=scott     DIRECTORY=DATA_PUMP_DIR     DUMPFILE=DATA_PUMP_DIR:expdp_20190416_%U.dmp
