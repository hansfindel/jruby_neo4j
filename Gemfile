source 'http://rubygems.org'

ruby '1.9.3', :engine => 'jruby', :engine_version => '1.7.2'
#ruby '1.8.7', :engine => 'jruby', :engine_version => '1.6.6'
gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#web server
#gem "thin" #problems with C-related dependencies
#gem "unicorn"  #set with 3 workers on production #problems with C-related dependencies
#gem "puma"
gem "trinidad"

#gem 'jruby-openssl'
gem "jruby-openssl", :platforms => :jruby
gem 'json'

# Gems used only for assets and not required
# in production environments by default.
gem 'haml-rails'
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyrhino'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'heroku'
# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'
gem 'bcrypt-ruby', :require => "bcrypt"

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

gem 'honeybadger' 

group :development, :test do
  gem "rspec-rails"
end

gem "neo4j", ">= 2.2.3"
gem "neo4j-community"
gem "neo4j-advanced" 
gem "neo4j-enterprise"