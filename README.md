# kat-djonson_infra
kat-djonson Infra repository
___
bastion_IP = 84.201.175.7
someinternalhost_IP = 10.130.0.7

_Connect to someinternalhost through bastion host:_
`ssh -A -J kat-djonson@bastion kat-djonson@someinternalhost`
or
`ssh -A -t kat-djonson@bastion ssh -t kat-djonson@someinternalhost`

_Connect via alias:_
- Create an alias
`echo "someinternalhost='ssh someinternalhost'" >> ~./zshrc`
or
`alias someinternalhost='ssh someinternalhost'`
- Add short configuration to ssh service
~/.ssh/config
```bash
Host bastion
    Hostname bastion
    User kat-djonson
    IdentityFile /Users/kat-djonson/.ssh/yacloud
    Port 22

Host someinternalhost
    Hostname someinternalhost
    User kat-djonson
    Port 22
    IdentityFile /Users/kat-djonson/.ssh/yacloud
    ProxyCommand ssh -A -W %h:%p bastion
```

_Connect to someinternalhost through VPN:_
- Install openvpn package according to local system requirements
- Run connection
`sudo openvpn /path/to/config/cloud-bastion.ovpn`

_Connect to Pritunl web-interface:_
https://84.201.175.7.sslip.io/login
___
testapp_IP = 84.201.131.18 \
testapp_port = 9292 \

_How to install Monolith Reddit application_
- install and run only one *startup_app.sh* file
- wait about 2 mim
- as a result:
1. VM instance will be created
2. Application will be run with address IP_VM:9292

_How it works_
- Startup file helps to create yc VM instance with unique configuration and pre-install custom scripts
1. There are two installation scripts: install_ruby.sh and install_mongo.sh for ruby and mongo components
2. There is deploy.sh script that configures installed packages and enables -demons- daemons on the cloud
3. Also we have build_app.sh config to combine all previous parts in one image
