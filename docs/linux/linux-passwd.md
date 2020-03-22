---
title:修改 密码策略
---

### 修改linux的密码策略
- BAD PASSWORD: it is based on a dictionary word
> 修改/etc/pam.d/system-auth 文件：将pam_cracklib.so所在的行的enforce_for_root去掉，用root账号可以将密码修改为简单密码

### Reference Link
- https://linux.die.net/man/8/pam_cracklib
