#!/bin/sh
set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

bundle exec rails db:create db:migrate db:seed
bundle exec puma -C config/puma.rb
