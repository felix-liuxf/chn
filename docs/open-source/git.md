---
title: git 基本用法
---
## git checkout 指定的文件夹
使用git clone可以获取远程服务器的所有仓库代码，然而有时想查看仓库里某个目录或文件，例如examples目录的时候。

从1.7.0版本开始git提供稀疏检出的功能。所谓稀疏检出就是本地版本库检出时不检出全部，只将指定的文件从本地版本库检出到工作区，而其他未指定的文件则不予检出
### git pull folder:docs
```
 git init
 git config core.sparsecheckout true
 echo "docs/*" >> .git/info/sparse-checkout 
 git pull master https://github.com/felix0102/chn.git 
 git checkout
```
## clone specific git branch
- git clone -b master https://github.com/felix0102/WeChatPlugin-MacOS.git
## checkout specific git branch
- git checkout <name_of_branch>
## list all branch
- git branch -a

## git commit 
- git add newfile
- git commit -m "comment"
- git push
