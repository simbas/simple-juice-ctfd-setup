#!/usr/bin/env bash
set -euo pipefail

if [ -f "./slides/${MARKDOWN_FILE}" ]; then
    reveal-md "./slides/${MARKDOWN_FILE}" --css "./slides/theme.css" --theme "${THEME}" --hightlight-theme "${HIGHLIGHT_THEME}" --static "./public"
    cp ./slides/*.jpg ./public/_assets/slides/
fi

cp scripts/docker.sh public/
cp scripts/shellter.sh public/
cp scripts/winscp.sh public/

http-server
