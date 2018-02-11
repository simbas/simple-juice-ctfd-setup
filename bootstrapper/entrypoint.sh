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

curl -s -o /dev/null --max-time 60 --retry 5 --retry-delay 10 --retry-max-time 30 --retry-connrefused ${URL}

echo "ctfd is reachable, starting configuration."

./setupAdmin.sh -u ${URL} -n ${NAME} -p ${PASSWORD} -c ${CTF} -e admin@${DOMAIN}
./addTeam.sh -u ${URL} -n ${NAME} -p ${PASSWORD} -t blue -m blue@${DOMAIN} -c blue
./addTeam.sh -u ${URL} -n ${NAME} -p ${PASSWORD} -t red -m red@${DOMAIN} -c red
./uploadBackup.sh -u ${URL} -n ${NAME} -p ${PASSWORD} -f juiceshop-chals.zip

for filename in challenges/*.zip; do
    ./uploadBackup.sh -u ${URL} -n ${NAME} -p ${PASSWORD} -f ${filename}
done
