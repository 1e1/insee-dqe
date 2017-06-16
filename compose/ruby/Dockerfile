FROM ruby:2.4.1

ENV RAILS_VERSION 5.0.3

# Rails standard
RUN apt-get update -qq \
  && apt-get install -y nodejs --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

# see http://guides.rubyonrails.org/command_line.html#rails-dbconsole
RUN apt-get update -qq \
  && rm -rf /var/lib/apt/lists/*
RUN gem install rails --version "$RAILS_VERSION"

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/Gemfile
#COPY Gemfile.lock /usr/src/Gemfile.lock
RUN bundle install --gemfile=/usr/src/Gemfile
# RUN rails new "$APP_NAME"

# Labacar and app-specific config
#ADD Gemfile /usr/src/Gemfile
#ADD Gemfile.lock /usr/src/app/Gemfile.lock
#RUN bundle install --gemfile=/usr/src/Gemfile
