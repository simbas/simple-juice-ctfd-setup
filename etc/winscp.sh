#!/usr/bin/env bash

set -e

echo "Downloading winscp..."

curl -fsSL https://winscp.net/download/WinSCP-5.13-Portable.zip -o /tmp/winscp.zip

unzip -d . /tmp/winscp.zip WinSCP.exe

echo "Download complete"
