#!/usr/bin/env bash
set -euo pipefail

setupAdmin() {
    local url=$1
    local ctf=$2
    local name=$3
    local email=$4
    local password=$5

    local redirect=''
    local token=''

    redirect=$(curl -s -o /dev/null -w "%{redirect_url}\n" "${url}")
    if [ "${redirect}" == "${url}/setup" ]; then
        token=$(curl -b cookies.txt --cookie-jar cookies.txt -s -L "${url}/" | pup '[name=nonce] attr{value}')
        curl -s -b cookies.txt -c cookies.txt -o /dev/null -F "nonce=${token}" -F "ctf_name=${ctf}" -F "name=${name}" -F "email=${email}" -F "password=${password}" -H "Expect:" "${url}/setup"
        echo "ctfd admin has been setup."
    else
        echo "request to ${url} was not redirected to ${url}/setup, ctfd seems to already have an admin config."
        exit 1
    fi
}

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
    setupAdmin "$1" "$2" "$3" "$4" "$5"
fi
