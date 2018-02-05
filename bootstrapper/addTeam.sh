#!/usr/bin/env bash


while getopts "u:n:t:m:c:p:" opt; do
  case $opt in
    u) URL="$OPTARG";;
    n) NAME="$OPTARG";;
    t) TEAM="$OPTARG";;
    m) MAIL="$OPTARG";;
    c) CREDENTIALS="$OPTARG";;
    p) PASSWORD="$OPTARG";;
  esac
done

TOKEN=$(curl -b cookies.txt --cookie-jar cookies.txt -s -L ${URL}/login | pup '[name=nonce] attr{value}')
curl -b cookies.txt -c cookies.txt -F "nonce=${TOKEN}" -F "name=${NAME}" -F "password=${PASSWORD}" -H "Expect:" ${URL}/login

TOKEN=$(curl -b cookies.txt --cookie-jar cookies.txt -s -L ${URL}/admin/teams | pup '#update-user-modal [name=nonce] attr{value}')
curl -b cookies.txt -c cookies.txt -F "nonce=${TOKEN}" -F "name=${TEAM}" -F "email=${MAIL}" -F "password=${CREDENTIALS}" -F "id=new" -F "website=" -F "affiliation=" -F "country="  -H "Expect:" ${URL}/admin/team/new
