## TheRole. Development environment

### Requirements

On your local machine you need some tools to start development process

- docker
- ruby
- git

versions of the tools are not very important. Just try to use the most recent ones.
### How to start environment

```sh
git clone https://github.com/TheRole/the_role_dev.git
```

```sh
ruby dev/setup
```

### How to run tests

```sh
ruby dev/test
```

### How to run Docker env

```sh
docker compose -f dockerfiles/docker-compose.yml build

docker compose -f dockerfiles/docker-compose.yml up

docker compose -f dockerfiles/docker-compose.yml exec ruby2.7.8 bash
```


### License

MIT
