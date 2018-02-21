Simple juice shop ctfd setup example
---

```
# pull the images
docker-compose -f ../docker-compose.yml --project-directory . pull

# run the ctf
docker-compose  -f ../docker-compose.yml --project-directory .  up --force-recreate --remove-orphans --build

# stop the ctf
docker-compose -f ../docker-compose.yml --project-directory . rm -s -f
```
