---
title: Load balancer service
---

## hostnames
- hostname1
- hostname1 关联 listener

## Rule Sets URL Redirect 
- Redirect Rule:http2https
- Redirect Rule 关联 Http Listener
```
URL Redirect Rules
Rule list table
Source Path: /
Match Type: Prefix Match
Redirect Protocol: https
Redirect Host: {host}
Redirect Port: 443
Redirect Path: {path}
Redirect Query: {query}
Response Code: 301   
```
>For the HTTP Listener only, you must also create and attach a Redirect Policy to direct the traffic from the LB to the appropriate destination origin server or virtual host1 HTTPS URL.  The "response code" field must be set to the value "301" within this Redirect Policy.

## Path Route Sets 
- RouteSet1
- RouteSet1 关联 Listener
>If URL matches (Exact Match) /hisensecrm/api/file/downloadController/download, direct traffic to backend set bs_lb_download


## Reference Link
- [URL Redirect & URL Rewriter](https://blogs.iis.net/owscott/url-rewrite-vs-redirect-what-s-the-difference)
- [URL Redirects & Rewriter](https://moz.com/blog/url-rewrites-and-301-redirects-how-does-it-all-work)

