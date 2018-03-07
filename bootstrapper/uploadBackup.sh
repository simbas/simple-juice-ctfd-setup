#!/usr/bin/env bash
set -euo pipefail

uploadBackup() {
    local url=$1
    local name=$2
    local password=$3
    local file=$4

    local token=''

    token=$(curl -b cookies.txt --cookie-jar cookies.txt -s -L "${url}/login" | pup '[name=nonce] attr{value}')
    curl -s -o /dev/null -b cookies.txt -c cookies.txt -F "nonce=${token}" -F "name=${name}" -F "password=${password}" -H "Expect:" "${url}/login"

    token=$(curl -b cookies.txt --cookie-jar cookies.txt -s -L "${url}/admin/config" | pup '[name=nonce] attr{value}')
    curl -s -o /dev/null -b cookies.txt -c cookies.txt -F "nonce=${token}" -F "segments=challenges" -F "backup=@${file}" -H "Expect:" "${url}/admin/import"
    echo "challenge backup ${file} has been uploaded."
}

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
    uploadBackup "$1" "$2" "$3" "$4"
fi
