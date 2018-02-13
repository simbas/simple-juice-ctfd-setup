Simple juice shop ctfd setup
----------------------------

Easily setup a Juice Shop CTF event with your coworkers.

features:
- 2 teams: red and blue
- no runtime env (except docker) required
- ctfd automatically configured for Juice Shop CTF

## How to use

### Production

```shell
docker-compose up
docker-compose rm -s -f
```

Paramaters (port, credentials, etc. check the `docker-compose.yml` file) are passed as environment variables: 
```shell
SJCS_CTFD_PORT=8080 SJCS_PASSWORD=secretpassword docker-compose up
```

|         Name           | Default value               | Description                                                 |
|:----------------------:|-----------------------------|-------------------------------------------------------------|
| `SJCS_CTFD_PORT`       | `80`                        | The mapped port with CTFd container port                    |
| `SJCS_WEB_PORT`        | `81`                        | The mapped port with the web container port                 |
| `SJCS_PATH`            | `./data`                    | The path on the filesystem where the database will be store |
| `SJCS_USER`            | `admin`                     | The username of the CTFd admin                              |
| `SJCS_TEAMS`           | `red,blue`                  | The teams to create (separated by `,`)                      |
| `SJCS_PASSWORD`        | `admin123`                  | The password of the CTFd admin                              |
| `SJCS_TITLE`           | `JuiceCTF`                  | The CTF name for CTFd                                       |
| `SJCS_CHALS_FOLDER`    | `./bootstrapper/challenges` | The path to the folder of custom zipped challenges backup   |
| `SJCS_DOMAIN`          | `mycompany.net`             | The domain used for email generation                        |
| `SJCS_SLIDES_FILE`     | `index.md`                  | The mardown file that will be used as slides                |
| `SJCS_SLIDES_FOLDER`   | `./web/slides`              | The path to the folder of markdown slides                   |
| `SJCS_SLIDES_THEME`    | `blood`                     | The reveal theme for the slides                             |
| `SJCS_SLIDES_HL_THEME` | `darcula`                   | The highlight reveal theme for the slides                   |

Install docker and pull the `juice-shop` image on kali linux:
```shell
curl -fsSL http://<the server ip>:81/kali-setup.sh | sh
```

### Development

```shell
docker-compose  -f docker-compose.yml -f docker-compose.dev.yml up --force-recreate --remove-orphans --build
```
