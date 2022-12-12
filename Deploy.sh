#!/bin/bash -x


if [ ! -f /usr/local/bin/flux ]; then 

echo -e "\n Installing fluxCD"

curl -s https://fluxcd.io/install.sh | sudo bash

. <(flux completion bash)

else 
 echo "Installed the flux"
fi 


export GITHUB_TOKEN='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'
export GITHUB_USER='arjunavinfra'


bootstraping() {
  echo $GITHUB_USER
  flux bootstrap github \
    --owner=$GITHUB_USER \
    --repository=fluxcd \
    --branch=main \
    --path=./clusters/my-cluster \
    --personal
  flux check --pre

}


while true

do

read -p  "Do you want to perform the bootstraping for Kerberos repo y / n " answer 

if [ $answer = y ]; then 
    bootstraping
    break 
elif [ $answer = n ]; then 

    flux check --pre
    break
else 
   echo "Invalid entry!!!!!"
fi

done

## Understand the gitops concept https://www.gitops.tech/#what-is-gitops

# understand basics of helm https://helm.sh/docs/ youtube link : https://www.youtube.com/watch?v=5QRxG02kfYg&list=PLh4KH3LtJvRRaW8Jtp0_4birma5nXlrFj

# fluxCD installation and understand the various controller in it.  https://fluxcd.io/flux/get-started/

# Control components:  https://fluxcd.io/flux/components/source/
# - flux get source git
# - flux get kustomization
# -  flux get kustomization --watch
# - flux create source git --help --export
# - flux create kustomization --help  --export

#learn GitRepository and kusatamization , Helm repostiry and helmrelease

#flux suspend kustomization <name>
#flux resume kustomization <name>
# Reconciliation in fluxCD  
#flux reconcile source git podinfo
#flux check


# flux cli comments https://fluxcd.io/flux/cmd/


# flux get all
# flux get kustomization 
# flux get sources all
