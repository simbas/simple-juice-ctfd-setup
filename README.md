Simple juice shop ctfd setup
----------------------------

Easily setup a Juice Shop CTF event with your coworkers.

features:
- 2 teams: red and blue
- no runtime env (except docker) required
- ctfd automatically configured for Juice Shop CTF

## How to use

```shell
docker-compose up --force-recreate --remove-orphans --build
docker-compose rm -s -f
```
