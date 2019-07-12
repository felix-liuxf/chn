
### 显示隐藏文件夹或文件

>在 macOS Sierra及以上(Mojave)，我们可以使用快捷键 ⌘⇧.(Command + Shift + .) 来快速（在 Finder 中）显示和隐藏隐藏文件了。

### 合上盖子不休眠
>时间的长度比较：sleep>=displaysleep>=disksleep
从图中看出disksleep单位是秒，一般都是最短的，而sleep和displaysleep是单位是分，系统要求是sleep的时间要大于等于displaysleep的时间，而我图里sleep（1）小于display（2），它们之间的时间冲突了导致mac在电池状态下没有正常进入休眠，所以你需要回到--系统偏好设置->节能->电池，把时间改成5分钟（反正要大于2）就可以了，改完后这时在terminal输入pmset -g custom 对比这3个参数
```
displaysleep
Mac闲置多长时间后进入显示器睡眠，单位是分钟，这个时间不能长于sleep下设置的时间
sleep
Mac闲置多长时间后进入睡眠，这个系统偏好设置里也有，单位是分钟
disksleep
Mac闲置多长时间后关闭硬盘。这个系统偏好里也有，只不过换了一个字眼—如果可能，使硬盘进入睡眠—勾上这个的话系统就会自动根据sleep的时间设一个合适的时间。单位是秒，这个时间不能长于sleep下设置的时间
```


