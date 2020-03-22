---
title: Backbone Remote Peering 
---
## Osaka <--> Jaddah
- Osaka vm 10.1.1.2  VCN-A 
- Jaddah vm 10.3.1.2 VCN-C 

## build connection step 

1. In Region Osaka
1. Create DRG-1
1. Create Remote Peering-1 
1. Attach VCN-A
1. Add DRG Route 10.3.0.0/16
1. In Region Jaddah
1. Create DRG-2
1. Create Remote Peering-2
1. Attach VCN-C
1. Add DRG Route 10.1.0.0/16
1. Establish remote peering connection from Osaka to Jaddah 

## traceroute private ip 10.3.1.2
```
traceroute to 10.3.1.2 (10.3.1.2), 30 hops max, 60 byte packets
 1  140.91.218.2 (140.91.218.2)  0.130 ms 140.91.218.7 (140.91.218.7)  0.093 ms  0.089 ms
 2  140.91.220.13 (140.91.220.13)  336.242 ms 140.91.220.3 (140.91.220.3)  336.195 ms  336.206 ms
 3  * * *
 4  * * *
```

## traceroute public ip 158.101.225.98
```
traceroute to 158.101.225.98 (158.101.225.98), 30 hops max, 60 byte packets
 1  140.91.218.2 (140.91.218.2)  0.140 ms 140.91.218.1 (140.91.218.1)  0.091 ms  0.085 ms
 2  140.91.220.5 (140.91.220.5)  336.302 ms 140.91.220.1 (140.91.220.1)  336.345 ms 140.91.220.2 (140.91.220.2)  336.021 ms
 3  * * *
 4  * * *
 5  * * *
```

## ping public ip 158.101.225.98
```
PING 158.101.225.98 (158.101.225.98) 56(84) bytes of data.
64 bytes from 158.101.225.98: icmp_seq=1 ttl=62 time=336 ms
64 bytes from 158.101.225.98: icmp_seq=2 ttl=62 time=336 ms
64 bytes from 158.101.225.98: icmp_seq=3 ttl=62 time=336 ms
```
## ping private ip 10.3.1.2
```
PING 10.3.1.2 (10.3.1.2) 56(84) bytes of data.
64 bytes from 10.3.1.2: icmp_seq=1 ttl=62 time=336 ms
64 bytes from 10.3.1.2: icmp_seq=2 ttl=62 time=336 ms
64 bytes from 10.3.1.2: icmp_seq=3 ttl=62 time=336 ms
64 bytes from 10.3.1.2: icmp_seq=4 ttl=62 time=336 ms
64 bytes from 10.3.1.2: icmp_seq=5 ttl=62 time=336 ms
```

## sftp private ip 10.3.12
```
Connected to 10.3.1.2.
sftp> put a.tar
Uploading a.tar to /home/opc/a.tar
a.tar                                         100%  267MB   5.6MB/s   00:47
sftp>
```


## sftp public ip 158.101.225.98
```
Connected to 158.101.225.98.
sftp> put a.tar
Uploading a.tar to /home/opc/a.tar
a.tar                                         100%  267MB   5.6MB/s   00:47
sftp>
```

## Backbone Test Result
Region | Ping 公网IP|ping 内网IP| sftp 公网速度|sftp 内网速度 |
-----|----|---|---|--|--
Sao Paulo 到 Tokyo|306ms|304ms|6.1MB/s|6.1MB/s
Sao Paulo 到 Mambai|305ms |305ms |6.1MB/s |6.1MB/s

saopaulo - tokyo 
PING 158.101.146.215 (158.101.146.215) 56(84) bytes of data.
64 bytes from 158.101.146.215: icmp_seq=1 ttl=62 time=315 ms
64 bytes from 158.101.146.215: icmp_seq=2 ttl=62 time=315 ms
64 bytes from 158.101.146.215: icmp_seq=3 ttl=62 time=315 ms
64 bytes from 158.101.146.215: icmp_seq=4 ttl=62 time=315 ms
64 bytes from 158.101.146.215: icmp_seq=5 ttl=62 time=315 ms

64 bytes from 10.1.1.2: icmp_seq=1 ttl=62 time=314 ms
64 bytes from 10.1.1.2: icmp_seq=2 ttl=62 time=314 ms
64 bytes from 10.1.1.2: icmp_seq=3 ttl=62 time=314 ms

Connected to 10.1.1.2.
sftp> put a.tar
Uploading a.tar to /home/opc/a.tar
a.tar                                         100%  267MB   6.1MB/s   00:44
sftp>

Connected to 152.67.38.64.
sftp> put a.tar
Uploading a.tar to /home/opc/a.tar
a.tar                                         100%  267MB   6.1MB/s   00:43
sftp
## Reference Link
- https://docs.cloud.oracle.com/en-us/iaas/Content/Network/Tasks/remoteVCNpeering.htm
