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

compartment-id:ocid1.compartment.oc1..aaaaaaaa7xl22idapafqbztwbjyhiwui6tilb3rm6q6hvf7yux2haae5st5q
availability-domain:dTZF:AP-SEOUL-1-AD-1
> oci iam availability-domain list -c ocid1.compartment.oc1..aaaaaaaa7xl22idapafqbztwbjyhiwui6tilb3rm6q6hvf7yux2haae5st5q
subnet-id:ocid1.subnet.oc1.ap-seoul-1.aaaaaaaack62wqme5l3njg4j5lpcpvn3znsgkxeihlc2mwii4fbblishqaxa
image-id:ocid1.image.oc1.ap-seoul-1.aaaaaaaalhbuvdg453ddyhvnbk4jsrw546zslcfyl7vl4oxfgplss3ovlm4q
>oci compute image list -c ocid1.compartment.oc1..aaaaaaaa7xl22idapafqbztwbjyhiwui6tilb3rm6q6hvf7yux2haae5st5q
shape:VM.Standard2.1
oci compute shape list -c ocid1.compartment.oc1..aaaaaaaa7xl22idapafqbztwbjyhiwui6tilb3rm6q6hvf7yux2haae5st5q --availability-domain "dTZF:AP-SEOUL-1-AD-1"

oci compute instance launch --availability-domain "dTZF:AP-SEOUL-1-AD-1" -c ocid1.compartment.oc1..aaaaaaaa7xl22idapafqbztwbjyhiwui6tilb3rm6q6hvf7yux2haae5st5q --shape "VM.Standard2.1"   --display-name "felixOL76"   --image-id ocid1.image.oc1.ap-seoul-1.aaaaaaaalhbuvdg453ddyhvnbk4jsrw546zslcfyl7vl4oxfgplss3ovlm4q --ssh-authorized-keys-file "/Users/felix/OProject/sshkeybundle/publicKey" --subnet-id  ocid1.subnet.oc1.ap-seoul-1.aaaaaaaack62wqme5l3njg4j5lpcpvn3znsgkxeihlc2mwii4fbblishqaxa
