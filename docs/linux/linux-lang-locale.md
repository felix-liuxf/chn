---
title: 
---

## setlocale: LC_CTYPE: 
 warning: setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory

### 服务端解决方法： 
- 在远程系统上， /etc/environment加入以下两行，重新登陆即可。
- LANG=en_US.utf-8
- LC_ALL=en_US.utf-8

### Mac终端解决方法： 
- 编辑~/.bashrc或者~/.zshrc文件，添加
- export LC_ALL=en_US.UTF-8  
- export LANG=en_US.UTF-8
