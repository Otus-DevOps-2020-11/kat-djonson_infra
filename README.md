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
