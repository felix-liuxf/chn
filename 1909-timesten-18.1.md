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

### JDBC code sample 
```java

import com.timesten.jdbc.TimesTenConnection;
import com.timesten.jdbc.TimesTenDataSource;

public class HelloConn {
	// TT connection
	public static void main(String[] args) {
		TimesTenDataSource ttDS = new TimesTenDataSource(); // TT datasource
		TimesTenConnection ttConn = null;
		// TODO Auto-generated method stub

		
			System.out.println("get Conn");
			String URL = "jdbc:timesten:client:DSN=sgttcs";

			ttDS.setUrl(URL);
			ttDS.setUser("osgpc");
			ttDS.setPassword("oracle");
			ttConn = (TimesTenConnection) ttDS.getConnection();
			// Connection conn = DriverManager.getConnection (URL);
			System.out.println(ttConn);
			// 执行SQL语句

			ttConn.close();

		} catch (Exception ex) {
			// 输出错误信息
			ex.printStackTrace();
		}

	}

}

```
