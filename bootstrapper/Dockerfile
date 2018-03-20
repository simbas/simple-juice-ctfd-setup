FROM debian:jessie

WORKDIR /usr/local/bootstrapper/

RUN echo "deb http://deb.debian.org/debian testing main" >> /etc/apt/sources.list
RUN apt update && apt install --yes unzip ca-certificates shellcheck nodejs npm && apt -t testing install --yes curl
RUN curl -L -s https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_amd64.zip -o pup.zip
RUN unzip pup.zip -d /usr/local/bin/
ADD . .
RUN shellcheck *.sh
RUN npm install

ENTRYPOINT ["./entrypoint.sh"]
