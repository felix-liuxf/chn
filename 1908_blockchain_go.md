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
