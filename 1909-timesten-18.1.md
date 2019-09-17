### JDBC connect Timesten

### client download
- https://www.oracle.com/database/technologies/timesten-downloads.html

### Get JDBC connect Timesten sample code
```
  git clone https://github.com/oracle/oracle-timesten-samples.git
  
  build jar
  
  cd oracle-timesten-samples/quickstart/scaleout/sample_code/jdbc
  
  make clean 
  
  make
  
```
### set CLASS_PATH

source $TIMESTEN_HOME/bin/ttenv.sh

### set Timesten Conf
```
get the properties of the conf from TIMESTEN SERVER 
set $TIMESTEN_HOME/conf/sys.odbc.ini
```

### Test connection 
```
  cd oracle-timesten-samples/quickstart/scaleout/sample_code/jdbc
  java GridSample -cs -dsn sgttcs -uid ttuser -pwd timesten
```

