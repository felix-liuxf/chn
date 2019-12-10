
### 安装Oracle instant client
```
yum install oracle-instantclient18.3-sqlplus

配置环境变量：
export ORACLE_HOME=/usr/lib/oracle/18.3/client64
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
PATH=$PATH:$HOME/.local/bin:$HOME/bin:/$ORACLE_HOME/bin

```

