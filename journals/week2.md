# Terraform Bootcamp Week 2

## Working with ruby

### Bundler
a ruby package manager/ ruby packages are called "gems". Bundler it's the way we install gems

To create a Gem, you make a GemFile and put them in there

```rb
# frozen_string_literal: true

source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

then you run `bundle install` to install the gems on the system globally... Worth noting, nodejs places packages in local node_modules folder... This is a difference between the languages

### Executing ruby scripts in the bundler
Must use `bundle exec` in gitpod.yml  so future ruby scripts use these gems too

```bash
  - name: sinatra
    before: | 
      cd $PROJECT_ROOT
      cd terratowns_mock_server
      bundle install
      bundle exec ruby server.rb 
```
### Sinatra

Sinatra is a micro web framework for ruby to build webapps. great for mock servers and simple project.. makes a webserver in a single file

https://sinatrarb.com/

## Terratowns Mock Sevrer

### Running the ruby web server
web server runs on the following code form the `server.rb` file

```bash
      bundle install
      bundle exec ruby server.rb 
```