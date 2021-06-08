FROM ruby:2.7.1
ARG BUNDLER_VERSION=2.1.4

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

#Postgresql
RUN apt-get install -y libpq-dev

#Nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

RUN gem install bundler -v 2.1.4

#Set an environment variable for the Rails app root folder
ENV RAILS_ROOT /var/www/dockerized-rails-api

#Create the working directory
RUN mkdir -p $RAILS_ROOT

WORKDIR $RAILS_ROOT
COPY Gemfile Gemfile.lock ./

RUN bundle config build.nokogiri --use-system-libraries
RUN bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java
RUN bundle check || bundle install

COPY . ./
COPY .env.example .env
COPY .git/ ./.git/

#Permission 755 allows the execute permission for all users to run the script
RUN chmod 755 ./entrypoints/app-server.sh

EXPOSE 3000
ENTRYPOINT ["./entrypoints/app-server.sh"]
