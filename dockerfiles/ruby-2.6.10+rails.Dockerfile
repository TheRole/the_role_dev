FROM ruby:2.6.10

SHELL ["/bin/bash", "--login", "-c"]

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# RAILS
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

# RUN gem install rails -v 4.2.11.3 --no-document
#
# In 2023 does not work correctly due to open dependencies
# Some gems want to fetch very modern gem versions that are not compatible with the old code
#
# gem 'spring', "2.1.0"
# gem "loofah", "2.5.0"
# gem "racc", "1.5.0"
# gem "nokogiri", "1.10.8"
# gem "rails-html-sanitizer", "1.3.0"

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

COPY rails4-app/Gemfile Gemfile
COPY rails4-app/Gemfile.lock Gemfile.lock
RUN bundle install

RUN rm -rf ../the_role_api
RUN rm -rf ../to_slug_param

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Remove Git warnings
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

RUN git config --global --add safe.directory /home/the_role_dev/the_role_api
RUN git config --global --add safe.directory /home/the_role_dev/to_slug_param

WORKDIR /home/the_role_dev
