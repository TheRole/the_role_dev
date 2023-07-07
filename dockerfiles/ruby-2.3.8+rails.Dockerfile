FROM ruby:2.3.8

SHELL ["/bin/bash", "--login", "-c"]

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# RAILS
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

RUN gem install rails -v 3.2.22.5 --no-document
RUN gem install bundler -v 1.17.3 --no-document

RUN mkdir /home/the_role_dev
RUN mkdir /home/the_role_dev/rails-versions

WORKDIR /home/the_role_dev/rails-versions

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# NODE.JS
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

ENV NVM_DIR="/opt/.nvm"
RUN mkdir /opt/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
RUN source /opt/.nvm/nvm.sh && nvm install 18.12.1

# source /opt/.nvm/nvm.sh

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Pre-install gems for different RoR versions
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

COPY the_role_api ../the_role_api
COPY to_slug_param ../to_slug_param

COPY rails3-app/Gemfile Gemfile
COPY rails3-app/Gemfile.lock Gemfile.lock
RUN bundle install

RUN rm -rf ../the_role_api
RUN rm -rf ../to_slug_param

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Remove Git warnings
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

RUN git config --global --add safe.directory /home/the_role_dev/the_role_api
RUN git config --global --add safe.directory /home/the_role_dev/to_slug_param

WORKDIR /home/the_role_dev
