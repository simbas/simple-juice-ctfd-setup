FROM debian:9

WORKDIR /usr/local/bootstrapper/

RUN apt update
RUN apt install --yes curl unzip ca-certificates
RUN curl -L -s https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_amd64.zip -o pup.zip
RUN unzip pup.zip -d /usr/local/bin/
ADD . .

ENTRYPOINT ["./entrypoint.sh"]
