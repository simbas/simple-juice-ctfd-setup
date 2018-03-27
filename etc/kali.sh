#!/usr/bin/env bash

set -e

echo "Killing PackageKit..."
kill -9 $(ps aux | grep "packagekit" | grep -v grep | awk '{ print $2 }')

echo "Installing docker..."

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo 'deb https://download.docker.com/linux/debian stretch stable' > /etc/apt/sources.list.d/docker.list

sed -i 's|http:|https:|g' /etc/apt/sources.list

dpkg-reconfigure debconf -f noninteractive -p critical

apt-get update
apt-get remove -y docker docker-engine docker.io
DEBIAN_FRONTEND=noninteractive apt-get install -y --quiet --no-install-suggests --no-install-recommends docker-ce
docker pull bkimminich/juice-shop:latest

echo "to run the juice shop please use the following command:"
echo "docker run --rm -e \"NODE_ENV=ctf\" -p 3000:3000 bkimminich/juice-shop:latest"
