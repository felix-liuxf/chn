### siebel run on OCI 
https://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/compute-iaas/deploy_siebel_instance_OCI_VM/deploy_siebel_instance_OCI_VM.html#section5
### Siebel run on AWS
https://docs.aws.amazon.com/zh_cn/AmazonRDS/latest/UserGuide/Oracle.Resources.Siebel.html
### jenkins password

```
修改这个文件完成密码修改： /var/lib/jenkins/users/siebel_*/config.xml 
siebel


jbcrypt:$2a$10$DdaWzN64JgUtLdvxWIflcuQu2fgrrMSAMabF5TSrGK5nXitqK9ZMS
111111

Restart Jenkins

/etc/init.d/jenkins restart
```

### enter URL
```
http://140.238.166.146:8080/
https://140.238.166.146:4430/siebel/app/eautomotive/enu
For Service - https://140.238.166.146:4430/siebel/app/callcenter/enu
For Siebel Management Console (SMC) - https://140.238.166.146:4430/siebel/smc
```
### SADMIN password
```
show ADMIN password :docker exec -it d14de4c1d503 env
https://docs.oracle.com/cd/E74890_01/books/Secur/secur_changepwd004.htm
```
