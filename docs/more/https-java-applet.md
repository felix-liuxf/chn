### https java applet

- We have a java applet on our website which worked for ages. Then Java 7 came out, people installed it. When people with Java 7 visiting our website using HTTPS, the applet failed to load (ClassNotFoundException). The same site and the same applet, when visit using regular HTTP, it works fine.

- People with the previous version of Java (1.6.x) can see the applet using either HTTP or HTTPs with no problem.

### Problem solved. 
- Long story short, the reason is that JSSE (Java Secure Socket Extension) implementation in Java 7, by default, has SNI (Server Name Indication) enabled by default, which require the server name set up on the SSL (Secure Sockets Layer) server.

In the case of Apache, we need to do the following:
```
<VirtualHost default:443>

# General setup for the virtual host
DocumentRoot "/opt/apache/2.2.21/htdocs"
ServerName your.servername.com:443
```
Previously we have this line commented out and it works for all the browser and all Java Applet, until Java 7 is out.

I had the same discussion on the Java Developer Forum below

- https://forums.oracle.com/forums/message.jspa?messageID=10330444#10330444
