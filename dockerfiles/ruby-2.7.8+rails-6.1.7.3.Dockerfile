FROM ruby:2.7.8-bullseye

SHELL ["/bin/bash", "--login", "-c"]

RUN apt-get update && apt-get install -y \
  wget \
  curl \
  telnet \
  vim

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# NODE.JS
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

ENV NVM_DIR="/opt/.nvm"
RUN mkdir /opt/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
RUN nvm install 18.12.1

# Update NPM and Yarn versions
RUN npm install -g npm@9.6.0
RUN npm install yarn -g
RUN yarn set version berry

# source /opt/.nvm/nvm.sh

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# RAILS
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

RUN gem install rails -v 6.1.7.3

RUN gem install pg      -v 1.5.3
RUN gem install mysql2  -v 0.5.5
RUN gem install sqlite3 -v 1.6.2

RUN gem install bundler

WORKDIR /

RUN /usr/local/bundle/bin/rails new app-psql   -d postgresql
RUN /usr/local/bundle/bin/rails new app-mysql  -d mysql
RUN /usr/local/bundle/bin/rails new app-sqlite -d sqlite3
