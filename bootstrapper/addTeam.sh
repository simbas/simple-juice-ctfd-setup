#!/usr/bin/env bash
set -euo pipefail

addTeam() {
    local url=$1
    local name=$2
    local team=$3
    local mail=$4
    local credentials=$5
    local password=$6
    local token=''

    token=$(curl -b cookies.txt --cookie-jar cookies.txt -s -L "${url}/login" | pup '[name=nonce] attr{value}')
    curl -s -o /dev/null -b cookies.txt -c cookies.txt -F "nonce=${token}" -F "name=${name}" -F "password=${password}" -H "Expect:" "${url}/login"

    token=$(curl -b cookies.txt --cookie-jar cookies.txt -s -L "${url}/admin/teams" | pup '#update-user-modal [name=nonce] attr{value}')
    curl -s -o /dev/null -b cookies.txt -c cookies.txt -F "nonce=${token}" -F "name=${team}" -F "email=${mail}" -F "password=${credentials}" -F "id=new" -F "website=" -F "affiliation=" -F "country="  -H "Expect:" "${url}/admin/team/new"

    echo "team ${team} has been added."
}

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
    addTeam "$1" "$2" "$3" "$4" "$5" "$6"
fi
