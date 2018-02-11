Simple juice shop ctfd setup
----------------------------

Easily setup a Juice Shop CTF event with your coworkers.

features:
- 2 teams: red and blue
- no runtime env (except docker) required
- ctfd automatically configured for Juice Shop CTF

## How to use

```shell
docker-compose up
docker-compose rm -s -f
```

Paramaters (port, credentials, etc. check the `docker-compose.yml` file) are passed as environment variables: 
```shell
CTF_PORT=8080 CTF_PASSWORD=secretpassword docker-compose up
```

Custom challenges (as CTFd backup) can be added in the `CTF_CHALS` folder.


dev mode:

```shell
docker-compose  -f docker-compose.yml -f docker-compose.dev.yml up --force-recreate --remove-orphans --build
```
