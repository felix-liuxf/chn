### OCI Command Line

oci os ns get

### get network information, run the following command.
```
oci network vcn list -c <compartment_id>
for example:
oci network vcn list -c ocid1.compartment.oc1..aaaaaaaa7xl22idapafqbztwbjyhiwui6tilb3rm6q6hvf7yux2haae5st5q
```

oci compute image list -c ocid1.compartment.oc1..aaaaaaaa7xl22idapafqbztwbjyhiwui6tilb3rm6q6hvf7yux2haae5st5q


### launch an instance you have to provide the following information, some of which you've already obtained:
```
compartment-id
availability-domain
subnet-id
image-id
shape
```
