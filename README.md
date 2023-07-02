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

### 5. Run tests in a container

```sh
ruby dev/test
```


### 6. Get in the Development conatiner

```sh
ruby dev/open
```

### License

MIT
