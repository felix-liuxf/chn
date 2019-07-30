#!/bin/sh
AVAILAIBILITY_DOMAIN="dTZF:AP-SEOUL-1-AD-1"
COMPARTMENT_OCID="ocid1.compartment.oc1..aaaaaaaa7xl22idapafqbztwbjyhiwui6tilb3rm6q6hvf7yux2haae5st5q"
BOOT_VOLUEME_OCID="ocid1.bootvolume.oc1.ap-seoul-1.abuwgljrwynwoggeirvkptzx42sfi2iod6clpjhd43strq2airwkk5gtx2gq"
SUBNET_OCID="ocid1.subnet.oc1.ap-seoul-1.aaaaaaaack62wqme5l3njg4j5lpcpvn3znsgkxeihlc2mwii4fbblishqaxa"
PUBLIC_IP_OCID="ocid1.publicip.oc1.ap-seoul-1.aaaaaaaalhsizpa2zydsgidjdtfospfsemxeyt6rlkjsvir43ryg2ba7puiq"
SSH_AUTHORIZED_KEYS_FILE="/Users/felix/OProject/sshkeybundle/publicKey"
INSTANCE_NAME="felixOL76"
INSTANCE_SHAPE="VM.Standard2.1"
PRIVATE_IP="10.0.7.7"
INSTANCE_STATE=""




create() {
    echo "==== Create Instance ..."
    
    INSTANCE_OCID=$(oci compute instance launch --availability-domain $AVAILAIBILITY_DOMAIN -c $COMPARTMENT_OCID --shape $INSTANCE_SHAPE   --display-name $INSTANCE_NAME   --source-boot-volume-id $BOOT_VOLUEME_OCID --private-ip $PRIVATE_IP --ssh-authorized-keys-file  $SSH_AUTHORIZED_KEYS_FILE --subnet-id  $SUBNET_OCID --assign-public-ip FALSE | grep \"id\" | awk -F'\"' '{print $4}')
    #echo "STATUS: $STATUS"
    echo "$INSTANCE_OCID" >".tmpINSTANCE_OCID"
    status
    while [ "$INSTANCE_STATE" == "PROVISIONING" ]
    do
    echo "sleep 10 s"
    sleep 10s
    status
    done;
    if [ "$INSTANCE_STATE" == "RUNNING" ] ; then
    echo "SET PUBLIC IP ..."
    setPublicIP
    fi
    
}


terminate() {
    status
    if [ "$INSTANCE_STATE" != "RUNNING" ] ; then
      echo "NOT FOUND THE RUNNING INSTANCE:$INSTANCE_NAME "
    else
    echo "==== Terminate Instance ..."
    #INSTANCE_OCID=$(oci compute instance list --compartment-id  $COMPARTMENT_OCID --display-name $INSTANCE_NAME --lifecycle-state RUNNING |grep \"id\"|awk -F'\"' '{print $4}')
    INSTANCE_OCID=$(cat ".tmpINSTANCE_OCID")
    if [ "$INSTANCE_OCID" == "" ] ; then
        echo "NOT FOUND THE RUNNING INSTANCE:$INSTANCE_NAME "
    else
    #echo "oci compute instance terminate --instance-id $INSTANCE_OCID --preserve-boot-volume true  --force"
    oci compute instance terminate --instance-id $INSTANCE_OCID --preserve-boot-volume true  --force

    status
    fi
    fi
    
    #echo "STATUS: $STATUS"
}
status() {
   #echo "oci compute instance list --compartment-id  $COMPARTMENT_OCID --display-name $INSTANCE_NAME  --limit 1 --sort-by  TIMECREATED --availability-domain $AVAILAIBILITY_DOMAIN";
   #STATUS=$(oci compute instance list --compartment-id  $COMPARTMENT_OCID --display-name $INSTANCE_NAME --limit 1 --sort-by  TIMECREATED --availability-domain $AVAILAIBILITY_DOMAIN |grep \"lifecycle-state\"|awk -F'\"' '{print $4}')
   INSTANCE_OCID=$(cat ".tmpINSTANCE_OCID")
   #echo "INSTANCE_OCID:$INSTANCE_OCID"
   if [ "$INSTANCE_OCID" == "" ] ; then
     getInstance_ocid
   fi
   INSTANCE_OCID=$(cat ".tmpINSTANCE_OCID")
   STATUS=$(oci compute instance get --instance-id $INSTANCE_OCID |grep \"lifecycle-state\"|awk -F'\"' '{print $4}')
   

   if [ "$STATUS" == "" ] ; then
        echo "NOT FOUND THE RUNNING INSTANCE:$INSTANCE_NAME "
    else
        echo "STATUS: $STATUS"
   fi
   INSTANCE_STATE=$STATUS
   
 
}
setPublicIP(){

    #echo "oci network private-ip list --subnet-id $SUBNET_OCID |grep \"id\"|awk -F'\"' '{print $4}'"
    PRIVATE_IP_OCID=$(oci network private-ip list --subnet-id $SUBNET_OCID --ip-address $PRIVATE_IP |grep \"id\"|awk -F'\"' '{print $4}')
    PUBLIC_IP=$(oci network public-ip update --public-ip-id  $PUBLIC_IP_OCID --private-ip-id $PRIVATE_IP_OCID |grep \"ip-address\"|awk -F'\"' '{print $4}')
    echo "PUBLIC IP:$PUBLIC_IP"
}

getInstance_ocid(){

  INSTANCE_OCID=$(oci compute instance list --compartment-id  $COMPARTMENT_OCID --display-name $INSTANCE_NAME --limit 1 --sort-by  TIMECREATED --availability-domain $AVAILAIBILITY_DOMAIN |grep \"id\"|awk -F'\"' '{print $4}')
  echo "$INSTANCE_OCID" >".tmpINSTANCE_OCID"
}


case "$1" in
    'create')
            create
            ;;
    'terminate')
            terminate
            ;;

    'status')
            status
            ;;
    *)
            echo
            echo "Usage: $0 { create | terminate | status }"
            echo
            exit 1
            ;;
esac

exit 0
