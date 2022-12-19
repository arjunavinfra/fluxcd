#!/bin/bash -x

# Generate a GPG key first:
export GPG_NAME="k3s.fluxcd.cluster"
export GPG_COMMENT="fluxcd-secrets-${RANDOM}"

gpg --batch --full-generate-key <<EOF
%no-protection
Key-Type: 1
Key-Length: 4096
Subkey-Type: 1
Subkey-Length: 4096
Expire-Date: 0
Name-Comment: ${GPG_COMMENT}
Name-Real: ${GPG_NAME}
EOF


#The code above will create an RSA key with 4096 bits. For full configuration of creating GPG keys


#Retrieve the key name

gpg --list-secret-keys "${GPG_NAME}"

#Store the GPG key fingerprint as an environment variable

GPG_ID=`gpg --list-secret-keys "${GPG_NAME}" | grep -B1 "${GPG_COMMENT}" |awk 'NR != 2' | sed 's/^[[:space:]]*//g'`



#export the public key and store it in the repo, so they can download and use the key to encrypt secrets

gpg --export --armor > ../../../clusters/production/.sops.pub.asc

#delete old key if any export the private key as a secrete for decryting fluxCD 

kubectl delete secret sops-gpg -n flux-system

# gpg --export-secret-keys --armor  "${GPG_ID}" |
# kubectl create  secret generic sops-gpg \
# --namespace=flux-system \
# --from-file=sops.asc=/dev/stdin



 cat <<EOF > ../../../clusters/production/.sops.yaml
creation_rules:
  - encrypted_regex: "^(data|stringData)$"
    # Specify kms/pgp/etc encryption key
    # This tutorial uses a local PGP key for encryption.
    # DO NOT USE IN PRODUCTION ENV
    pgp: "${GPG_ID}"
    # Optionally you can configure to use a providers key store
    # kms: XXXXXX
    # gcp_kms: XXXXXX
EOF

#Delete the private key created locally from the local machine as the secret is on the cluster now.

gpg --delete-secret-keys "${GPG_ID}"
rm -rf .sops



#gpg --import ./clusters/production/.sops.pub.asc --for encrypt from local  brfore decrypt the file
