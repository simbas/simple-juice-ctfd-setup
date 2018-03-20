#!/usr/bin/env bash
set -euo pipefail

entrypoint() {
    local url=$1
    local ctf=$2
    local name=$3
    local domain=$4
    local password=$5
    local teams=$6

    curl -s -o /dev/null --retry 10 --retry-delay 10 --retry-max-time 30 --retry-connrefused "http://juice-shop:3000"

    echo "juice-shop is ready, starting challenges generation."

    ./generate.js

    curl -s -o /dev/null --retry 10 --retry-delay 10 --retry-max-time 30 --retry-connrefused "${url}"

    echo "ctfd is reachable, starting configuration."

    ./setupAdmin.sh "${url}" "${ctf}" "${name}" "admin@${domain}" "${password}"

    for team in $(echo "${teams}" | tr "," "\n"); do
        ./addTeam.sh "${url}" "${name}" "${team}" "${team}@${domain}" "${team}" "${password}"
    done

    ./uploadBackup.sh "${url}" "${name}" "${password}" juice-shop-challenges.zip
    for filename in challenges/*.zip; do
        ./uploadBackup.sh "${url}" "${name}" "${password}" "${filename}"
    done
}

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
    while getopts "u:c:n:d:p:t:" opt; do
        case $opt in
            u) url="$OPTARG";;
            c) ctf="$OPTARG";;
            n) name="$OPTARG";;
            d) domain="$OPTARG";;
            p) password="$OPTARG";;
            t) teams="$OPTARG";;
        esac
    done

    entrypoint "${url}" "${ctf}" "${name}" "${domain}" "${password}" "${teams}"
fi
