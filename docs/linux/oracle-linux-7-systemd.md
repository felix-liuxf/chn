### service template
```
[Unit]
Description=Chat Server Service
After=network.target

[Service]
Type=simple
ExecStart=/bin/bash /home/ankush/chat_server/start.sh

[Install]
WantedBy=multi-user.target
```
- systemctl daemon-reload
- systemctl start chat_server

### Reference link
- https://geekflare.com/systemd-start-services-linux-7/
- https://www.linode.com/docs/quick-answers/linux/start-service-at-boot/