---
title: curl 使用
---

## curl 访问https协议
In order to prevent this error and accept an insecure certificate, we need to provide--insecure This will accept all provided certificates without complaining about it.

- curl --insecure https://www.wikipedia.com 

## curl 检查端口是否打开

curl是利用URL语法在命令行方式下工作的开源文件传输工具。也可以用来测试端口的连通性，
### 具体用法:
- curl ip:port
>说明：ip：是测试主机的ip地址port：是端口，比如80
如果远程主机开通了相应的端口，都会输出信息，如果没有开通相应的端口，则没有任何提示，需要CTRL+C断开。

## curl 下载文件
- 使用内置option：-O（大写)

> curl -O http://www.linux.com/dodo1.JPG

- 循环下载
有时候下载图片可以能是前面的部分名称是一样的，就最后的尾椎名不一样
>  curl -O http://www.linux.com/dodo[1-5].JPG

这样就会把dodo1，dodo2，dodo3，dodo4，dodo5全部保存下来

## Reference Link
- [cnblogs curl](https://www.cnblogs.com/duhuo/p/5695256.html)
