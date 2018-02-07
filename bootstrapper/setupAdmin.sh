#!/usr/bin/env bash

set -e

while getopts "u:c:n:e:p:" opt; do
  case $opt in
    u) URL="$OPTARG";;
    c) CTF="$OPTARG";;
    n) NAME="$OPTARG";;
    e) EMAIL="$OPTARG";;
    p) PASSWORD="$OPTARG";;
  esac
done

REDIRECT_URL=$(curl -s -o /dev/null -w "%{redirect_url}\n" ${URL})
if [ "${REDIRECT_URL}" == "${URL}/setup" ]; then
    TOKEN=$(curl -b cookies.txt --cookie-jar cookies.txt -s -L ${URL}/ | pup '[name=nonce] attr{value}')
    curl -s -b cookies.txt -c cookies.txt -o /dev/null -F "nonce=${TOKEN}" -F "ctf_name=${CTF}" -F "name=${NAME}" -F "email=${EMAIL}" -F "password=${PASSWORD}" -H "Expect:" ${URL}/setup
    echo "ctfd admin has been setup."
else
    echo "request to ${URL} was not redirected to ${URL}/setup, ctfd seems to already have an admin config."
    exit 1
fi
