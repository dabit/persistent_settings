# Persistent Settings

[![Build Status](https://secure.travis-ci.org/dabit/persistent_settings.png)](http://travis-ci.org/dabit/persistent_settings)

A simple key value store for ActiveRecord based applications.

Best used to store global app settings.

## Installation

Add it to your Gemfile

    gem 'persistent_settings'

Install

    bundle install

Use the generator to create a Config class, or whatever you want to call it, that
will include all the Persistent Settings functionality.

    rails g persistent_settings:create config

Run migrations

    rake db:migrate

## Usage

Assuming that your Persistent Settings class is named Config, it will automatically create new
keys as you assign a value to them.

    Config.a_key = 'value'

Reload your app:

    Config.a_key # => 'value'

It accepts all kinds of objects as the value

## Known Issues

Sometimes, settings are not loaded automatically at startup. If that's the case
add an initializer to your Rails app.

    #
    # config/initializers/settings.rb
    #

    Settings.load_from_persistance

# License

MIT License. Copyright 2011, Crowd Interactive http://www.crowdint.com
