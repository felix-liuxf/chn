---
title: 首页
---
## 系统截屏
用苹果电脑自带的截图功能的快捷键：
- command+shift+3 三个键按下则抓取/截取全屏……
- command+shift+4 然后用鼠标框选则抓取该区域的截图……
- command+shift+4 然后按空格则抓取软件窗口。
- 截图会自动保存到桌面。
- Xnip 的免费软件，可以获得超长滚动截屏
## HomeBrew 关闭自动更新
mac上使用brew install /brew cask install安装软件总是先updating HomeBrew…

我们可以关闭自动更新，在命令行执行：

>export HOMEBREW_NO_AUTO_UPDATE=true
## 配置代理curl,wget,ssh
- netstat -rn 查看路由，通过路由你可以知道你的系统通过哪个webgate服务器上网
- 配置http_proxy 
>export http_proxy="http://10.188.53.53:80"  

## 环境变量-启用或关闭http_proxy代理 
- proxyon 启用代理
- proxyoff 关闭代理
- 在~/.bash_profile里面添加如下的function
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

## shell脚本设置环境变量

1. 执行脚本时是在一个子shell环境运行的，脚本执行完后该子shell自动退出；
1. 一个shell中的系统环境变量才会被复制到子shell中（用export定义的变量）；
1. 一个shell中的系统环境变量只对该shell或者它的子shell有效，该shell结束时变量消失（并不能返回到父shell中）。
1. 不用export定义的变量只对该shell有效，对子shell也是无效的。
1.  用source xxx.sh 可以让环境变量在当前窗口生效.
