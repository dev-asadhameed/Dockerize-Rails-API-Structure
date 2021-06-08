# Dockerized Rails API Structure
This is a simple API only rails application.

## Requirements
- Ruby 2.7.1
- Rails 6.0.3

## Database
- Postgres 12

## Installation steps
- git clone git@github.com:dev-asadhameed/Dockerize-Rails-API-Structure.git
- cd dockerized_rails_api
- bundle install
- rake db:create
- rake db:migrate
- rails s

## Run tests
- rspec

## Quick start for local development

If you don't want to install yet another postgres version on your system, try this.

You need [Docker](https://docs.docker.com/get-docker/) and ruby 2.7.1 installed. Then, run:

```
$ docker-compose up --build
```

The API will be running at http://localhost:3000/
