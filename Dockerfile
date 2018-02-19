# Image Ruby
FROM ruby:2.4.1

# Install Essentials
RUN apt-get update -qq \
    && apt-get install -y build-essential libpq-dev nodejs software-properties-common apt-transport-https

# Install Heroku CLI
RUN add-apt-repository -y "deb https://cli-assets.heroku.com/branches/stable/apt ./" \
    && curl -L https://cli-assets.heroku.com/apt/release.key | apt-key add - \
    && apt-get update \
    && apt-get install -y heroku \
    && apt-get clean \
    && heroku plugins:install heroku-cli-deploy

RUN mkdir /app
WORKDIR /app

# Generate Gemfile
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app