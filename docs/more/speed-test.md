###  install speed test OoklaServer
```
 sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
 sudo systemctl restart firewalld.service
 wget https://install.speedtest.net/ooklaserver/ooklaserver.sh
 chmod a+x ooklaserver.sh
 ./ooklaserver.sh install
 
```

### Reference Link
- https://support.ookla.com/hc/en-us/articles/234578528-OoklaServer-Installation-Linux-Unix
