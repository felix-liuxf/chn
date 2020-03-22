---
title: ssh 常用功能
---
## ssh 使用http代理 
存在A B C三台主机， 由于安全因素或者其他，A不能直接与C通信。 但是存在B可以与A,C通信。 则现在需要在A上通过ssh, 假设B已经搭建好一个http代理，专门来代理ssh访问C的服务。具体方法分为2种常见做法:
- 1.通过软件 corkscrew作为proxy的客户端
- 2.通过ncat作为proxy的客户端
不过最终本质是一样的，ssh通过命令 ssh -o ProxyCommand="xxx"的形式设置代理信息，即可使用,过程是对用户透明无感的。
> ssh -i /Users/felix/Dafeng/AWS/aws-seoul-key-pair.pem  ec2-user@54.180.125.138  -o  ProxyCommand="corkscrew 10.188.53.53 80 %h %p"

### ssh方便切换是否使用http_proxy
- 在.bash_profile里面配置http proxy
```
# No Proxy
function proxyoff
{
  export http_proxy=""
  export https_proxy=""
  export ssh_proxy=""
}


# Proxy
function proxyon
{
  export http_proxy=http://10.188.53.53:80/
  export https_proxy=$http_proxy
  export ssh_proxy="-o ProxyCommand=\"corkscrew 10.188.53.53 80 %h %p\""
}
```
- 在shell脚本里面调用ssh命令
```
#!/usr/bin/env bash
SSH="ssh -i /Users/felix/Dafeng/AWS/aws-seoul-key-pair.pem  ec2-user@54.180.125.138 $ssh_proxy"
echo $SSH
eval $SSH
```
- 切换是否使用http proxy
> proxyon proxyoff 


## ssh 三种代理功能

- 正向代理（-L）：相当于 iptable 的 port forwarding
```
用法1：远程端口映射到其他机器
HostB 上启动一个 PortB 端口，映射到 HostC:PortC 上，在 HostB 上运行：
HostB$ ssh -L 0.0.0.0:PortB:HostC:PortC user@HostC
这时访问 HostB:PortB 相当于访问 HostC:PortC（和 iptable 的 port-forwarding 类似）。
用法2：本地端口通过跳板映射到其他机器
HostA 上启动一个 PortA 端口，通过 HostB 转发到 HostC:PortC上，在 HostA 上运行：
HostA$ ssh -L 0.0.0.0:PortA:HostC:PortC  user@HostB
这时访问 HostA:PortA 相当于访问 HostC:PortC。
两种用法的区别是，第一种用法本地到跳板机 HostB 的数据是明文的，而第二种用法一般本地就是 HostA，访问本地的 PortA，数据被 ssh 加密传输给 HostB 又转发给 HostC:PortC
```
- 反向代理（-R）：相当于 frp 或者 ngrok
```
所谓“反向代理”就是让远端启动端口，把远端端口数据转发到本地。
HostA 将自己可以访问的 HostB:PortB 暴露给外网服务器 HostC:PortC，在 HostA 上运行：
HostA$ ssh -R HostC:PortC:HostB:PortB  user@HostC
那么链接 HostC:PortC 就相当于链接 HostB:PortB。使用时需修改 HostC 的 /etc/ssh/sshd_config，添加：
GatewayPorts yes
相当于内网穿透，比如 HostA 和 HostB 是同一个内网下的两台可以互相访问的机器，HostC是外网跳板机，HostC不能访问 HostA，但是 HostA 可以访问 HostC。
那么通过在内网 HostA 上运行 ssh -R 告诉 HostC，创建 PortC 端口监听，把该端口所有数据转发给我（HostA），我会再转发给同一个内网下的 HostB:PortB。
同内网下的 HostA/HostB 也可以是同一台机器，换句话说就是内网 HostA 把自己可以访问的端口暴露给了外网 HostC。
按照前文《韦易笑：内网穿透：在公网访问你家的 NAS》中，相当于再 HostA 上启动了 frpc，而再 HostC 上启动了 frps。
```
- socks5 代理（-D）：相当于 ss/ss
```
在 HostA 的本地 1080 端口启动一个 socks5 服务，通过本地 socks5 代理的数据会通过 ssh 链接先发送给 HostB，再从 HostB 转发送给远程主机：
HostA$ ssh -D localhost:1080  HostB
那么在 HostA 上面，浏览器配置 socks5 代理为 127.0.0.1:1080，看网页时就能把数据通过 HostB 代理出去，类似 ss/ssr 版本，只不过用 ssh 来实现。
```

## ssh port forward
- ssh -D 1080 -i /Users/felix/OProject/sshkeybundle/privateKey -C -N opc@140.238.6.13

>note to understand all options for ssh simply type man ssh in a new terminal window. The options used above -D binds the port to the IP, -C compresses the data, -N will not execute commands in the tunnel which is very useful for forwarding other application data through the tunnel.

### HostB:15210->HostC:1521
- ssh -g -f -N -L 15210:HostC:1521 user@HostC
- ssh -i rsa_key_hisense_crm -g -f -N -L 15001:10.0.11.5:1521 opc@10.0.11.5


### Reference Link
- https://blog.csdn.net/wxqee/article/details/49234595
- https://zhuanlan.zhihu.com/p/57630633
