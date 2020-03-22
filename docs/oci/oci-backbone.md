## OCI Backbone
All traffic between the regions traverses the Oracle backbone.

### OCI Backbone FAQ
What is the Oracle Cloud Infrastructure Backbone?
The Oracle Cloud Infrastructure (OCI) backbone is a secure network for interconnecting geographic regions. It provides a privately routed transport with more consistent inter-region latency and jitter when compared to the public Internet.

### When do I use the OCI Backbone?
You use the OCI backbone network for all your private, inter-region VCN-to-VCN, as well as your public application or workload inter-region traffic.

How do I get started with the OCI backbone?
You don’t have to take any actions or apply specific configurations to use the OCI backbone. When you exchange traffic between two VCNs or public endpoints located in two different regions, your traffic automatically traverses over the OCI backbone.

Which OCI regions are connected via the backbone?
Currently, the following regions are interconnected via the OCI backbone network:
Phoenix
Ashburn
London
Frankfurt

Do you offer a Service Level Agreement (SLA) for inter region connectivity?
Yes, Oracle provides a 99.95% availability SLA for inter region connectivity over the Oracle backbone.

Can I opt out of using the OCI backbone?
You cannot opt out of using the OCI backbone.

How will I be charged and billed for using the OCI backbone?
You will be charged per GB delivered. Your bill will show a single line item for metered outbound data transfer to the Internet and to another region.

What is the price for transferring data between OCI regions?
Please refer to the latest published pricing for “Outbound Data Transfer”.

Is traffic flowing over the OCI backbone encrypted?
Yes. Traffic traversing over the OCI backbone is encrypted using industry standard link encryption.

Can I configure a redundant transport for inter-region connectivity?
Yes, you can attach an Internet Gateway to your VCN and specify a public route, via the Internet Gateway, to public endpoints located in a remote OCI region. In the unlikely event of a failure in the OCI backbone, your traffic may fail over to the Oracle Internet Service Provider (ISP) network.

Can I ensure no public inter-region traffic is routed over the internet?
Yes. You can ensure Oracle does not route your public inter-region traffic over the Internet by not attaching an Internet Gateway to your VCN


## network traffic

OCI，AWS,Ali云厂商在自己的数据中心之间都有自己的云骨干网相连。
OCI的backbone和AWS，Ali的云骨干网之间的区别是：
如果是public ip直接通信：
OCI默认是走自己云骨干网（backbone）
AWS，Ali默认是走公网进行传输
如果是private ip，经过配置后（比如网关，路由），OCI，AWS，Ali都走自己的云骨干网。


## price

#### OCI backbone 
 10T Free | $0.0085/G  
#### AWS VPC Region不同收费不一样。 https://aws.amazon.com/cn/vpc/pricing/
```
美国东部 弗吉尼亚 NAT 网关每处理 1GB 数据，您就需要支付 0.045 USD，并且在 NAT 网关已配置且可用后，您每小时需支付 0.045 USD。
亚太香港 0.065 
亚太孟买 0.056
亚太首尔 0.059
国内的Region 没有该服务
```

## Aliyun
- 计费方式：支持包年包月和按量计费两种计费方式。详细信息，请参见包年包月和按量计费。https://help.aliyun.com/document_detail/48126.html?spm=5176.8160608.691358.doc33.4746695d0n0cDU
- 按量计费：Middle规格单价 23元/天 690/月 
https://help.aliyun.com/document_detail/88658.html?spm=a2c4g.11186623.2.10.1ba8f8c6eyxYVY#concept-e5m-qkb-n2b
- 包年包月：Middle规格单价（元/月）586.5元/月 
https://help.aliyun.com/document_detail/88657.html?spm=a2c4g.11186623.2.9.1ba8f8c6OjEbcN#concept-isv-4kb-n2b


## Azure Virtual network 

- Global VNET Peering https://azure.microsoft.com/en-us/pricing/details/virtual-network/

数据 | ZONE 1	| ZONE 2 | ZONE 3 | US GOV
--|------------|-------------|------------|-------------
Inbound data transfer	|$0.035 per GB	|$0.09 per GB|	$0.16 per GB|	$0.044 per GB
Outbound data transfer	|$0.035 per GB	|$0.09 per GB	|$0.16 per GB	|$0.044 per GB

*Global VNET Peering pricing is based on a zonal structure. For instance, if data is being transferred from a VNET in zone 1 to a VNET in zone 2, customers will incur outbound data transfer rates for zone 1 and inbound data transfer rates for zone 2.


