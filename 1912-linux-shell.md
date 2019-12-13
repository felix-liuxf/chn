###  批量杀死进程
- ps -ef | grep oracle | grep -v grep | awk '{print "kill -9 "$2}' | sh

### 计算多少行
- ps -ef |wc -l

