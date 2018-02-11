#!/usr/bin/env bash

set -e

while getopts "u:n:f:p:" opt; do
  case $opt in
    u) URL="$OPTARG";;
    n) NAME="$OPTARG";;
    f) FILE="$OPTARG";;
    p) PASSWORD="$OPTARG";;
  esac
done

TOKEN=$(curl -b cookies.txt --cookie-jar cookies.txt -s -L ${URL}/login | pup '[name=nonce] attr{value}')
curl -s -o /dev/null -b cookies.txt -c cookies.txt -F "nonce=${TOKEN}" -F "name=${NAME}" -F "password=${PASSWORD}" -H "Expect:" ${URL}/login

TOKEN=$(curl -b cookies.txt --cookie-jar cookies.txt -s -L ${URL}/admin/config | pup '[name=nonce] attr{value}')
curl -s -o /dev/null -b cookies.txt -c cookies.txt -F "nonce=${TOKEN}" -F "segments=challenges" -F "backup=@${FILE}" -H "Expect:" ${URL}/admin/import
echo "challenge backup ${FILE} has been uploaded."
