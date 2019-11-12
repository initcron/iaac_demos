#!/bin/bash

sudo sudo apt-get update
sudo apt-get install -yq git wget

# Install Docker
sudo apt-get install -yq \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get install -yq docker-ce

sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose > /dev/null 2>&1

sudo chmod +x /usr/local/bin/docker-compose

echo "I: completed installing docker and docker-compose....."

exit 0
