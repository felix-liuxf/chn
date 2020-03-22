### shell sftp upload
```
#!/bin/bash
#SFTP配置信息
#用户名
USER=root
#密码
PASSWORD=5EYS40T04BMF
#待上传文件根目录
SRCDIR=/u02/dab/sftpFiles
#FTP目录
DESDIR=/u01/sftpFiles
#IP
IP=192.168.10.11
#端口
PORT=22022

#获取文件
cd ${SRCDIR} ;
#目录下的所有文件
#FILES=`ls` 
#修改时间在执行时间五分钟之前的xml文件
FILES=`find ${SRCDIR} -mmin -50 -name '*.xml'`

for FILE in ${FILES}
do
    echo ${FILE}
#发送文件 (关键部分）
lftp -u ${USER},${PASSWORD} sftp://${IP}:${PORT} <<EOF
cd ${DESDIR}/
lcd ${SRCDIR}
put ${FILE}
by
EOF
```