### mongodb URI

https://docs.mongodb.com/manual/reference/connection-string/

### 数据库常用指令
```
mongo 进入命令行 或 mongo + 数据库名字
show dbs 显示数据库列表
use + 数据库名字 使用指定数据库
show collections 显示当前数据库下的所有集合（类似表）
db.collectionName.find() 显示集合里的数据
db.collectionName.find({“name”:”blue”}) 查找集合中name = blue的数据的所有信息
db.collectionName.remove({“name”:”blue”}) 删除集合中name=blued的数据
db.dropDatabase() 删除当前使用的数据库
db.cloneDatabase(‘localhost’) 将指定主机的数据库克隆到当前数据库
db.copyDatabase(“mydb”,”temp”,”127.0.0.1”) 将本机的mydb数据库复制到temp数据库
db.repairDatabase(); 修复当前数据库
db或db.getName() 获取当前使用的数据库名称
db.stats() 显示当前db状态
db.getMongo() 显示当前db的链接地址
```
### 集合collection 常用指令
```
db.createCollection(“collectionName”，{size:20,capped:5,max:100}) 创建一个集合，通常mongdb可以自动创建
db.getCollection(‘collectionName’) 得到知道名称的集合
db.getCollectionNames() 得到当前db的所有集合 === show collections
db.printCollectionStats() 显示当前db所有集合的索引状态
```
### 用户相关
```
db.addUser(‘username’) 添加一个用户，如：db.addUser(‘username’,’pwd123’,true) 添加用户，密码 是否只读
db.auth(“username”,”password”) 数据库认证，安全模式
show users 显示当前所有用户
db.removeUser(“username”) 删除用户
```
### 其他关于集合常用命令

#### PS : 假设集合名称为 person
```
db.person.count() 当前集合的数据条数
db.person.dataSize() 查看数据空间大小
db.person.getDB() 得到当前集合的所的数据库
db.person.stats() 得到当前集合的状态
db.person.totalSize() 得到集合的总大小
db.person.stroageSize() 得到存储的空间大小
db.person.renameCollection(‘newName’) 对集合重新命名
db.person.drop() 删除当前集合
db.person.find() 查询当前集合的所有数据
db.person.distinct(“name”) 查询去掉后的当前集合中某列的重复数据
db.person.find({“name”: 正则表达式}) 按指定正则查找
db.person.find({},{“name”:false}) 查询person中所有数据，并去掉每条数据中的name信息 （过滤信息）
db.person.find().sort({age:1}) 按年龄升序排序查找 -1 表示降序
db.person.find({name:’zhangsan’,age:21}) 查询name为zhansan age为21的数据相关信息
db.person.find().limit(5) 查询前5条信息
db.person.find().skip(10) 查询10条以后的数据
db.person.find().limit(10).skip(5) 查询 5-10条数据
db.person.find({$or:[{age:22},{age:25}]}) or查询 查找age为22或25
db.person.find({age:{$gte:25}}).count() 查找age>=25 的结果数据的条数
db.person.find({“age”:20}) 按条件查找，如：
db.person,find({“age”:{$gt:22}}) 查找age大于22的记录 db.person.find({“age”:{$lt:22}}) 查找age小于22的记录 db.person.find({“age”:{$gte:23,$lte:26}}); 23<= age <=26
```
###增删改操作

####PS : 假设集合名称为 person
```
db.person.save({“name”:”blue”,”age”:23,”sex”:true}) 添加一条数据
db.person.update({age:25},{$set:{name:’blue’}},false,true) 跟新person中age为25 的所有数据的 name 为 blue
db.person.update({name:’blue’},{$inc:{age:10}},false,true) 跟新person中name为blue 的所有数据的 age都加10
b.person.update({name: ‘Lisi’}, {$inc: {age: -5}, $set: {name: ‘blue’}}, false, true); 更新person中name为lisi的所有数据的age 减5同时设置name为blue
db.person.remove({name:“blue”，age:”23”}) 删除person中name为blue age为23的所有数据
```
