#!/usr/bin/env bash

set -e

while getopts "u:c:n:d:p:" opt; do
  case $opt in
    u) URL="$OPTARG";;
    c) CTF="$OPTARG";;
    n) NAME="$OPTARG";;
    d) DOMAIN="$OPTARG";;
    p) PASSWORD="$OPTARG";;
  esac
done

curl --max-time 60 --retry 5 --retry-delay 10 --retry-max-time 30 --retry-connrefused ${URL}

./setupAdmin.sh -u ${URL} -n ${NAME} -p ${PASSWORD} -c ${CTF} -e admin@${DOMAIN}
./uploadBackup.sh -u ${URL} -n ${NAME} -p ${PASSWORD} -f backup.zip
./addTeam.sh -u ${URL} -n ${NAME} -p ${PASSWORD} -t blue -m blue@${DOMAIN} -c blue
./addTeam.sh -u ${URL} -n ${NAME} -p ${PASSWORD} -t red -m red@${DOMAIN} -c red
