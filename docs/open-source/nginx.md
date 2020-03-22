---
title: nginx 常用配置
---
## 配置反向代理
### 配置反向代理例子
```
server {
        listen       80;
        server_name  localhost;
        location / {
         rewrite ^/(.*) https://$host/$1 permanent;
        }
    }

       server {
        listen 443 ssl;
        error_page  404 404.html;
        server_name _;
        ssl_certificate "/etc/nginx/server.crt";
        ssl_certificate_key "/etc/nginx/server.key";
        ssl_session_timeout 5m;
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2; #按照这个协议配置
        ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;#按照这个套件配置
        ssl_prefer_server_ciphers on;
        location / {
            proxy_set_header Host $host:$server_port;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_pass https://132.145.230.64;
        }
    }
```

## 配置gzip功能
### gzip 打开例子
ginx实现资源压缩的原理是通过ngx_http_gzip_module模块拦截请求，并对需要做gzip的类型做gzip，ngx_http_gzip_module是Nginx默认集成的，不需要重新编译，直接开启即可。
```
gzip on;
gzip_min_length  5k;
gzip_buffers     4 16k;
#gzip_http_version 1.0;
gzip_comp_level 3;
gzip_types       text/plain application/javascript text/css application/xml text/javascript application/x-httpd-php image/jpeg image/gif image/png;
gzip_vary on;
```
### 配置指令详细注释
```
gzip on|off
# 默认值: gzip off
# 开启或者关闭gzip模块

gzip_static on|off

# nginx对于静态文件的处理模块
# 该模块可以读取预先压缩的gz文件，这样可以减少每次请求进行gzip压缩的CPU资源消耗。该模块启用后，nginx首先检查是否存在请求静态文件的gz结尾的文件，如果有则直接返回该gz文件内容。为了要兼容不支持gzip的浏览器，启用gzip_static模块就必须同时保留原始静态文件和gz文件。这样的话，在有大量静态文件的情况下，将会大大增加磁盘空间。我们可以利用nginx的反向代理功能实现只保留gz文件。
# 可以google"nginx gzip_static"了解更多

gzip_comp_level 4

# 默认值：1(建议选择为4)
# gzip压缩比/压缩级别，压缩级别 1-9，级别越高压缩率越大，当然压缩时间也就越长（传输快但比较消耗cpu）。

gzip_buffers 4 16k

# 默认值: gzip_buffers 4 4k/8k
# 设置系统获取几个单位的缓存用于存储gzip的压缩结果数据流。 例如 4 4k 代表以4k为单位，按照原始数据大小以4k为单位的4倍申请内存。 4 8k 代表以8k为单位，按照原始数据大小以8k为单位的4倍申请内存。
# 如果没有设置，默认值是申请跟原始数据相同大小的内存空间去存储gzip压缩结果。

gzip_types mime-type [mime-type ...]

# 默认值: gzip_types text/html (默认不对js/css文件进行压缩)
# 压缩类型，匹配MIME类型进行压缩
# 不能用通配符 text/*
# (无论是否指定)text/html默认已经压缩
# 设置哪压缩种文本文件可参考 conf/mime.types

gzip_min_length  1k

# 默认值: 0 ，不管页面多大都压缩
# 设置允许压缩的页面最小字节数，页面字节数从header头中的Content-Length中进行获取。
# 建议设置成大于1k的字节数，小于1k可能会越压越大。 即: gzip_min_length 1024

gzip_http_version 1.0|1.1

# 默认值: gzip_http_version 1.1(就是说对HTTP/1.1协议的请求才会进行gzip压缩)
# 识别http的协议版本。由于早期的一些浏览器或者http客户端，可能不支持gzip自解压，用户就会看到乱码，所以做一些判断还是有必要的。
# 注：99.99%的浏览器基本上都支持gzip解压了，所以可以不用设这个值,保持系统默认即可。
# 假设我们使用的是默认值1.1，如果我们使用了proxy_pass进行反向代理，那么nginx和后端的upstream server之间是用HTTP/1.0协议通信的，如果我们使用nginx通过反向代理做Cache Server，而且前端的nginx没有开启gzip，同时，我们后端的nginx上没有设置gzip_http_version为1.0，那么Cache的url将不会进行gzip压缩

gzip_proxied [off|expired|no-cache|no-store|private|no_last_modified|no_etag|auth|any] ...

# 默认值：off
# Nginx作为反向代理的时候启用，开启或者关闭后端服务器返回的结果，匹配的前提是后端服务器必须要返回包含"Via"的 header头。
off - 关闭所有的代理结果数据的压缩
expired - 启用压缩，如果header头中包含 "Expires" 头信息
no-cache - 启用压缩，如果header头中包含 "Cache-Control:no-cache" 头信息
no-store - 启用压缩，如果header头中包含 "Cache-Control:no-store" 头信息
private - 启用压缩，如果header头中包含 "Cache-Control:private" 头信息
no_last_modified - 启用压缩,如果header头中不包含 "Last-Modified" 头信息
no_etag - 启用压缩 ,如果header头中不包含 "ETag" 头信息
auth - 启用压缩 , 如果header头中包含 "Authorization" 头信息
any - 无条件启用压缩

gzip_vary on

# 和http头有关系，加个vary头，给代理服务器用的，有的浏览器支持压缩，有的不支持，所以避免浪费不支持的也压缩，所以根据客户端的HTTP头来判断，是否需要压缩

gzip_disable "MSIE [1-6]."

# 禁用IE6的gzip压缩，又是因为杯具的IE6。当然，IE6目前依然广泛的存在，所以这里你也可以设置为“MSIE [1-5].”
# IE6的某些版本对gzip的压缩支持很不好，会造成页面的假死，今天产品的同学就测试出了这个问题
后来调试后，发现是对img进行gzip后造成IE6的假死，把对img的gzip压缩去掉后就正常了
为了确保其它的IE6版本不出问题，所以建议加上gzip_disable的设置
```

## 配置代理缓存
```
proxy_cache_path /cache levels=1:2 keys_zone=cache:10m max_size=10g inactive=60m use_temp_path=off;

server{
	listen 80;
	server_name proxya.com;
	location / {
		proxy_pass http://proxyb.com;
	}
	location ~ .*\.(gif|jpg|png|css|js)(.*)  {
        proxy_pass http://proxyb.com;
		proxy_cache cache;
    	proxy_cache_valid   200 304 12h;
    	proxy_cache_valid   any 10m;
    	add_header  Nginx-Cache "$upstream_cache_status";
		proxy_cache_key $host$uri$is_args$args;
	}
}

# proxy_cache_path 缓存文件存放位置
# levels=1:2       代表缓存的目录结构为2级目录
# keys_zone=cache:10m 申请一个10兆的空间存在缓存的key 名称为cache
# max_size 最大存储缓存的空间10G
# inactive 未被访问文件在缓存中保留时间，本配置中如果60分钟未被访问则不论状态是否为expired，缓存控制程序会删掉文件。inactive默认是10分钟。
           需要注意的是，inactive和expired配置项的含义是不同的，expired只是缓存过期，但不会被删除，inactive是删除指定时间内未被访问的缓存文件
# use_temp_path 如果为off，则nginx会将缓存文件直接写入指定的cache文件中，而不是使用temp_path存储。
# proxy_cache cache;  启动名称为cache的缓存
# proxy_cache_valid 200 302 10m; 只对响应码为200，301，302的访问请求资源设置缓存时间10m
```
