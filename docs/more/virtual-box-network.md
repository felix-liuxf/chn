### network type
 ![network](https://technology.amis.nl/wp-content/uploads/2018/07/virtualbox-networking-overview.png)

### network port forwarding

```
In the Port Forwarding Rules window, click the + button and fill out the new rule as such:

Name - SSH
Protocol - TCP
Host IP - leave blank
Host Port - 2222
Guest IP - leave blank
Guest Port - 22
```
- Connecting to the guest
- ssh -p2222 USERNAME@127.0.0.1


### Reference Link
- https://technology.amis.nl/2018/07/27/virtualbox-networking-explained/
- https://www.virtualbox.org/manual/ch06.html