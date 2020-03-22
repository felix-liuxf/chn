---
title: 首页
---
## shell第一行
```
#!/bin/bash 以bash shell来解释
#!/bin/csh 以csh shell来解释
#!bin/sh 以下代码由sh shell来解释
linux有多个shell，bash shell、cshell，它们都是因为有不同的需求而产生。。所以有些脚本代码适合这个SHELL，有的适合那个SHELL 就用上面的方法来说明了。
```
## 命令有引号在shell中如何写
- 直接在Terminal可以执行，在shell脚本里面不能执行，报下面的错误
> ERROR:cannot execute binary file
### 解决办法:通过eval执行这样的脚本
```
eval $SHELL_SCRIPT
```
### 解决办法:写到临时文件里面，然后执行
解决办法，将执行的脚本写到一个临时文件里面，然后执行脚本
```
echo $SHELL_SCRIPT >./temp.sh
chmod 755 ./temp.sh
./temp.sh
rm -f ./temp.sh
```

## MAC查看系统默认的shell
- 查看所有的shell
>cat /etc/shells
```
# List of acceptable shells for chpass(1).
# Ftpd will not allow users to connect who are not using
# one of these shells.
/bin/bash
/bin/csh
/bin/dash
/bin/ksh
/bin/sh
/bin/tcsh
/bin/zsh
```
- 查看当前窗口使用的shell版本
（不要被一个叫 $SHELL 的单独的环境变量所迷惑，它被设置为你的默认 shell 的完整路径。因此，这个变量并不一定指向你当前使用的 shell。例如，即使你在终端中调用不同的 shell，$SHELL 也保持不变）
> echo $SHELL
- 查看系统用户默认shell
> cat /etc/passwd |grep sh
```
root:*:0:0:System Administrator:/var/root:/bin/sh
_sshd:*:75:75:sshd Privilege separation:/var/empty:/usr/bin/false
_update_sharing:*:95:-2:Update Sharing:/var/empty:/usr/bin/false
_mbsetupuser:*:248:248:Setup User:/var/setup:/bin/bash
```
root用户默认时sh 其他用户时 bash
- 输出当前使用的shell
> echo $0
