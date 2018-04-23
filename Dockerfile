FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /repec
WORKDIR /repec
COPY Gemfile /repec/Gemfile
COPY Gemfile.lock /repec/Gemfile.lock
RUN bundle install
COPY . /repec
