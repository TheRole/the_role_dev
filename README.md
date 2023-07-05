## TheRole. Development Environment

### Requirements

On your local machine you need some tools to start development process

- docker
- ruby
- git

versions of the tools are not very important. Just try to use the most recent ones.
## How to start developement process?

### 1. Clone the Repository

```sh
git clone https://github.com/TheRole/the_role_dev.git --recursive
```

```sh
cd the_role_dev
```

### 3. Build a Docker Image

```sh
ruby dev/build
```

### 4. Start Docker containers

```sh
ruby dev/start
```

### 5. Run Tests in a Container

```sh
ruby dev/test
```

### 6. Get in the Development Conatiner

```sh
ruby dev/open
```

### 7. Check status of Docker containers

```sh
ruby dev/status
```

### License

MIT
