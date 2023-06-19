## TheRole. Development environment

### How to start environment

```sh
git clone git@github.com:TheRole/the_role_dev.git
```

```sh
ruby dev/setup
```

```sh
docker compose -f dockerfiles/docker-compose.yml build

docker compose -f dockerfiles/docker-compose.yml up

docker compose -f dockerfiles/docker-compose.yml exec ruby2.7.8 bash
```


### License

MIT
