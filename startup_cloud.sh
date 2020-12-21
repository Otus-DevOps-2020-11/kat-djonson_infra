#!/bin/bash

RSA_KEY=$(cat ~/.ssh/appuser.pub)

cat > metadata.yaml << EOM
#cloud-config
disable_root: true
timezone: Europe/Moscow
repo_update: true
repo_upgrade: true
apt:
  preserve_sources_list: true

users:
    - default
    - name: yc-user
      sudo: ALL=(ALL) NOPASSWD:ALL
      shell: /bin/bash
      ssh-authorized-keys:
        - $RSA_KEY

runcmd:
  - curl https://raw.githubusercontent.com/Otus-DevOps-2020-11/kat-djonson_infra/cloud-testapp/build_app.sh | bash
EOM

#yandex cloud instance creating
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=./metadata.yaml

rm -f metadata.yaml
