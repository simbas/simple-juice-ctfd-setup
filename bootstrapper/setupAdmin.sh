#!/usr/bin/env bash


while getopts "u:c:n:e:p:" opt; do
  case $opt in
    u) URL="$OPTARG";;
    c) CTF="$OPTARG";;
    n) NAME="$OPTARG";;
    e) EMAIL="$OPTARG";;
    p) PASSWORD="$OPTARG";;
  esac
done

TOKEN=$(curl -b cookies.txt --cookie-jar cookies.txt -s -L ${URL}/ | pup '[name=nonce] attr{value}')

echo $TOKEN

curl -b cookies.txt -c cookies.txt -F "nonce=${TOKEN}" -F "ctf_name=${CTF}" -F "name=${NAME}" -F "email=${EMAIL}" -F "password=${PASSWORD}" -H "Expect:" ${URL}/setup
