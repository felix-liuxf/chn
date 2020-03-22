## mac routing operation
### 查看路由
- netstat -rn

### route add syntax
route -n add -net  destination gateway [netmask]

### 添加缺省路由
- route -n add defalut  10.13.31.1
### 添加路由
- route -n add  -net 10.0.0.0/8  10.13.31.1
### 删除路由
- route -n delete defalut  10.13.31.1