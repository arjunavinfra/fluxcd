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
    --repository=calcus \
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
