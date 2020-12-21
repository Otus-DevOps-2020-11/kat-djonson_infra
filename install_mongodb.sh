#!/bin/bash

sudo apt-get install -y apt-transport-https ca-certificates
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add - && echo "Manga is OK" || echo "Smth went wrong"
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list && echo "OK" || echo "Ne OK"
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod
if [[ "$(sudo systemctl is-active mongod)" != "active" ]]
then
    echo "Mongodb has not been loaded"
    exit 1
fi
