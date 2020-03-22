---
title: 定时执行 crontab
---

### crontab 每2小时执行一次

```
10 */2 * * * /usr/local/bin/node /Users/felix/OProject/20200220-kyle/puppeteer/index.js>/Users/felix/$(date +%Y%m%d-%H%M%S).log
```
### mac crontab 

- 查看crontab -l
- 修改crontab -e

```
使用crontab定时任务只需两步
1、查看 crontab 是否启动（非必要，可跳过）
sudo launchctl list | grep cron
2、命令行创建crontab执行文件"testing_crontab"
vi testing_crontab

##输入以下代码
*/1 * * * * /bin/date >> /Users/xx/time.txt
##esc，wq!保存
以上代码是每分钟执行一次date命令，输出时间到time.txt文本

3、使用crontab命令调用crontab文件
crontab testing_crontab
```
### Reference Link
- https://www.jianshu.com/p/7ecf40421cf2

