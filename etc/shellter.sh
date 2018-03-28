i#!/usr/bin/env bash

set -e

echo "Killing PackageKit..."
kill -9 $(ps aux | grep "packagekit" | grep -v grep | awk '{ print $2 }')

echo "Installing shellter..."

dpkg --add-architecture i386
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y --quiet --no-install-suggests --no-install-recommends wine32 shellter

echo "to run shellter please use the following command:"
echo "shellter"
