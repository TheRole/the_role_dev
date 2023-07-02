## TheRole. Development environment

### Requirements

On your local machine you need some tools to start development process

- docker
- ruby
- git

versions of the tools are not very important. Just try to use the most recent ones.
## How to start developement process?

### 1. Clone the Repo

```sh
git clone https://github.com/TheRole/the_role_dev.git
```

```sh
cd the_role_dev
```

### 2. Download and Prepare related things

```sh
ruby dev/setup
```

### 3. Build a Docker Image for development

```sh
ruby dev/build
```

### 4. Start a Docker container for development

```sh
ruby dev/start
```

### 5. Get in the Development conatiner

```sh
ruby dev/open
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
