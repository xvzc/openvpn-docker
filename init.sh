#!/bin/bash

docker run -v $OVPN_DATA:/etc/openvpn \
  --rm kylemanna/openvpn ovpn_genconfig \
  -u udp://$(curl https://whatsmyip.co | xargs)

docker run -v $OVPN_DATA:/etc/openvpn \
  --rm -it kylemanna/openvpn ovpn_initpki nopass
