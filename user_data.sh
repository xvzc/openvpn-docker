#!/bin/bash

export OVPN_DATA="/home/ubuntu/openvpn"
echo 'export OVPN_DATA="/home/ubuntu/openvpn"' >> /home/ubuntu/.bashrc

mkdir /home/ubuntu/openvpn

sudo apt-get update

sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo usermod -aG docker $USER
newgrp docker

/usr/bin/newgrp docker <<EONG

docker run -v $OVPN_DATA:/etc/openvpn \
  --rm kylemanna/openvpn ovpn_genconfig \
  -u udp://$(curl https://whatsmyip.co | xargs)

docker run -v $OVPN_DATA:/etc/openvpn \
  --rm -it kylemanna/openvpn ovpn_initpki nopass

docker run -v $OVPN_DATA:/etc/openvpn -d \
  -p 1194:1194/udp \
  --cap-add=NET_ADMIN kylemanna/openvpn

EONG

