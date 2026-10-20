#!/bin/bash
# Starts the OpenVPN server for the lab
cd /workspaces/OpenVpn-online-lab

# Make sure the tunnel device exists
sudo mkdir -p /dev/net
if [ ! -c /dev/net/tun ]; then
  sudo mknod /dev/net/tun c 10 200
fi

sudo openvpn --config server.conf