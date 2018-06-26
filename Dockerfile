FROM ruby:2.4.1

ENV RAILS_VERSION 5.1

# Rails standard
RUN apt-get update -qq \
  && apt-get install -y nodejs --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

# see http://guides.rubyonrails.org/command_line.html#rails-dbconsole
#RUN apt-get update -qq \
#  && rm -rf /var/lib/apt/lists/*
RUN gem install rails --version "$RAILS_VERSION"

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile ./Gemfile
COPY Gemfile.lock ./Gemfile.lock
RUN bundle install --jobs=4
# RUN rails new "$APP_NAME"

# Labacar and app-specific config
#ADD Gemfile /usr/src/Gemfile
#ADD Gemfile.lock /usr/src/app/Gemfile.lock
#RUN bundle install --gemfile=/usr/src/Gemfile
