#!/bin/bash

sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential

minimal_version="2.2.0"
current_version=$(ruby -v | awk '{print $2}')

if [[ $(echo -e "$minimal_version\n$current_version" | sort -V | head -n1) != "$minimal_version" ]]
then
    echo "Too old ruby version"
    exit 1
fi

minimal_version="1.11.2"
current_version=$(bundler -v | awk '{print $3}')

if [[ $(echo -e "$minimal_version\n$current_version" | sort -V | head -n1) != "$minimal_version" ]]
then
    echo "Too old bundler version"
    exit 1
fi
