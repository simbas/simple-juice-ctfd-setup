#!/usr/bin/env bash

set -e

while getopts "u:c:n:d:p:t:" opt; do
  case $opt in
    u) URL="$OPTARG";;
    c) CTF="$OPTARG";;
    n) NAME="$OPTARG";;
    d) DOMAIN="$OPTARG";;
    p) PASSWORD="$OPTARG";;
    t) TEAMS="$OPTARG";;
  esac
done

curl -s -o /dev/null --max-time 60 --retry 5 --retry-delay 10 --retry-max-time 30 --retry-connrefused ${URL}

echo "ctfd is reachable, starting configuration."

./setupAdmin.sh -u ${URL} -n ${NAME} -p ${PASSWORD} -c ${CTF} -e admin@${DOMAIN}

for team in $(echo $TEAMS | tr "," "\n"); do
    ./addTeam.sh -u ${URL} -n ${NAME} -p ${PASSWORD} -t ${team} -m ${team}@${DOMAIN} -c ${team}
done

./uploadBackup.sh -u ${URL} -n ${NAME} -p ${PASSWORD} -f juiceshop-chals.zip
for filename in challenges/*.zip; do
    ./uploadBackup.sh -u ${URL} -n ${NAME} -p ${PASSWORD} -f ${filename}
done
