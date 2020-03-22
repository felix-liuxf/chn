---
title: Docker 常用命令
---

## Docker exec 命令

>docker exec [OPTIONS] CONTAINER COMMAND [ARG...]

>docker exec -i -t  mynginx /bin/bash

### 查看
- docker ps: 查看当前运行的容器
- docker ps -a:查看所有容器，包括停止的。
### 启动
- 容器名：docker start docker_name，
- 者ID：docker start 43e3fef2266c。

### 终止
- docker stop [NAME]/[CONTAINER ID]:将容器退出。
- docker kill [NAME]/[CONTAINER ID]:强制停止一个容器。
