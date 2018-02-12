#!/usr/bin/env bash

set -e

echo "Installing docker..."

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo 'deb https://download.docker.com/linux/debian stretch stable' > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get remove docker docker-engine docker.io
apt-get install docker-ce
docker pull bkimminich/juice-shop:latest

echo "to run the juice shop please use the following command:"
echo "docker run --rm -e \"NODE_ENV=ctf\" -p 3000:3000 bkimminich/juice-shop:latest"
