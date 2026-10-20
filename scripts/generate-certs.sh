#!/bin/bash
# Creates the certificates and keys an OpenVPN server and client need
set -e

export EASYRSA_BATCH=1
CA_DIR="$HOME/openvpn-ca"
OUT_DIR="/workspaces/OpenVpn-online-lab/certs"

# Set up a fresh Easy-RSA folder
rm -rf "$CA_DIR"
make-cadir "$CA_DIR"
cd "$CA_DIR"

./easyrsa init-pki
EASYRSA_REQ_CN="OpenVPN-Lab-CA" ./easyrsa build-ca nopass
./easyrsa build-server-full server nopass
./easyrsa build-client-full client1 nopass
./easyrsa gen-dh
openvpn --genkey secret ta.key

# Copy everything into the lab folder
mkdir -p "$OUT_DIR"
cp pki/ca.crt pki/dh.pem ta.key "$OUT_DIR"
cp pki/issued/server.crt pki/private/server.key "$OUT_DIR"
cp pki/issued/client1.crt pki/private/client1.key "$OUT_DIR"

echo "Done. Files are in $OUT_DIR:"
ls -l "$OUT_DIR"

