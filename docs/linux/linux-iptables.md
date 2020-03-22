---
title: iptable 基本用法
---

### 使用iptables进行端口重定向
我们的要将端口80重定向到同一服务器中的端口8080。这可以通过PREROUTING链中添加规则来完成。因此，运行以下命令。

> iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080

### 查看重定向的端口
> iptables -t nat -L -n -v

### 保存修改
> iptables-save
