### JDBC Support for Database Sharding


https://docs.oracle.com/en/database/oracle/oracle-database/12.2/jjdbc/database-sharding.html#GUID-1D7795CA-79DC-452B-9FCC-0EF430F87461

```
 OracleDataSource ods = new OracleDataSource();
      ods.setURL("jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS=(HOST=myhost)(PORT=1521)(PROTOCOL=tcp))(CONNECT_DATA=(SERVICE_NAME=myorcldbservicename)))");
      ods.setUser("hr");
      ods.setPassword("hr");

     // Employee name is the sharding Key in this example.
     // Build the Sharding Key using employee name as shown below.

      OracleShardingKey employeeNameShardKey = ods.createShardingKeyBuilder()
                                                  .subkey("Mary", JDBCType.VARCHAR)// First Name
                                                  .subkey("Claire", JDBCType.VARCHAR)// Last Name
                                                  .build();

      OracleShardingKey locationSuperShardKey = ods.createShardingKeyBuilder() // Building a super sharding key using location as the key
                                                   .subkey("US", JDBCType.VARCHAR)
                                                   .build();

      OracleConnection connection = ods.createConnectionBuilder()
                                       .shardingKey(employeeNameShardKey)
                                       .superShardingKey(locationSuperShardKey)
                                       .build();
```
