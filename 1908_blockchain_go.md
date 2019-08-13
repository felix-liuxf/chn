### go lang env
```
GOROOT : the path that installation go lang.
GOPATH : the path that development go lang applications.
```

### goclipse installation

- https://github.com/GoClipse/goclipse/blob/latest/documentation/Installation.md#installation

### Go tools installation
- preferences --> go --> tools --> downloads

- gocode: go get -u github.com/nsf/gocode (-u flag for "update")
- guru:go get   golang.org/x/tools/cmd/guru
- godef:go get -u -v github.com/rogpeppe/godef


### add Hyperledger lib 
```
mkdir -p $GOPATH/src/github.com/hyperledger
cd $GOPATH/src/github.com/hyperledger
git clone -b release-1.2 https://github.com/hyperledger/fabric.git
```
###  Use a Mock Shim to Test a Chaincode

  - https://docs.oracle.com/en/cloud/paas/blockchain-cloud/user/use-mock-shim-test-chaincode.html

### Go Lang ebook

- https://github.com/unknwon/the-way-to-go_ZH_CN/blob/master/eBook/directory.md



### Postman 测试 
- https://myservices-cacct-2886f2a8f3a24cee93d4418ad6e73a45.console.oraclecloud.com/mycloud/cloudportal/gettingStarted
- http://192.168.56.101:3001/bcsgw/rest/v1/transaction/invocation

### REST API Sample

- https://docs.oracle.com/en/cloud/paas/blockchain-cloud/rest-api/op-restproxy-bcsgw-rest-v1-transaction-invocation-post.html

### curl test
```
curl -u felix.liuxf@qq.com:Huanying_123  -X GET https://9290E7F740304BC49D11C75333815DC4.blockchain.ocp.oraclecloud.com:443/restproxy1/bcsgw/rest/version
curl -u felix.liuxf@qq.com:Huanying_123 -H Content-type:application/json  -X POST -d '{"channel":"default","chaincode":"example02","method":"query","args":["RedCar"],"chaincodeVer":"V1"}' https://9290E7F740304BC49D11C75333815DC4.blockchain.ocp.oraclecloud.com:443/restproxy1/bcsgw/rest/v1/transaction/invocation

```
