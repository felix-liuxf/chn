### yum 查看已经安装的软件

- yum list all ── 列出所有已安装的和可用的软件包
- yum list installed ── 列出所有已经安装在系统中的软件包。输出结果的最右边一列是取得该软件包的软件仓库。标识为 installed 的软件包则说明它是做为系统基本组件而预安装的。
- yum list available ── 列出所有启用的软件仓库中可用的软件包
- yum grouplist ── 列出所有软件包组
- yum repolist ── 列出所有启用的软件仓库的 ID，名称 及其包含的软件包的数量


### 新建 /etc/yum.repos.d/google-chrome.repo,写入如下内容:
```
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
```
- yum -y install google-chrome-stable --nogpgcheck