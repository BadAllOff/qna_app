# Questions and answers application (TDD|BDD)
[![volkswagen status](https://auchenberg.github.io/volkswagen/volkswargen_ci.svg?v=1)](https://github.com/auchenberg/volkswagen)

This app based on main idea of stackowerflow: people can ask questions and create answers for them, created for lerning how some gems and technologies works.
Features:

Actions mostly works without reload (ajax) New records appears on page without reload for all users (comet) Faye through private pub

NOT DONE!

    gem 'private_pub'
    gem 'thin'

Authentication with Facebook & Twitter

NOT DONE!

    gem 'devise'
    gem 'omniauth'

Authorization with Policies

    gem 'cancancan'

App has REST API

NOT DONE!

    gem 'doorkeeper'
    gem 'active_model_serializers'

Attach files to questions/answers

    gem 'carrierwave'

Background jobs (like email)

NOT DONE!

    gem 'sidekiq'
    gem 'whenever'
    ActiveJob

Redis for sidekiq and caching

NOT DONE!

    Fragment caching (Russian doll caching)
    gem 'redis-rails'

Sphinx search

NOT DONE!

    gem 'thinking-sphinx'

Test Driven Developed more than 400 Rspec tests examples written before code

    gem 'rspec-rails'
    gem 'factory_girl_rails'
    gem 'shoulda-matchers'

Feature (acceptance) testing with JS

    gem 'capybara'
    gem 'capybara-webkit'

Views written on Slim & Bootstrap

    gem 'slim'
    gem 'bootstrap-sass'

PostgreSQL as main db

    gem 'pg'

Ready to Deploy

NOT DONE!

    gem 'capistrano'
    gem 'therubyracer'

Unicorn as production webserver

NOT DONE!

    gem 'unicorn'

Ruby version

    ruby 2.2.1

Services (job queues, cache servers, search engines, etc.)

NOT DONE!

    Postgres
    Redis
    Sidekiq
    PrivatePub(thin)
    Sphinx

Deployment instructions

NOT DONE!

    cap production deploy
