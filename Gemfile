source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# CSS Framework
gem 'bootstrap-sass'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :production do
  gem 'pg'
  gem 'rails_12factor' # for the asset pipeline
end

# in dev use sqlite3 for active record
group :development do
  gem 'sqlite3'
end

group :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'capybara', '~> 2.3.0'
  gem 'shoulda-matchers', '~> 3.0.0.alpha'
  # use FactoryGirls for rspec tests
  gem 'factory_girl_rails', '~> 4.0'
  # rspec coverage of code
  gem 'simplecov', require: false
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Rubocop checks my code for style and convention violations
  gem 'rubocop', require: false

  # check output in response and by using related methods
  gem 'pry-rails'
end

# haml for cleaner mark-up
gem 'haml', '~> 4.0.5'
# seed the database
gem 'faker'
# pundit for authorization
gem 'pundit'
# Authentication
gem 'devise'
# Manage sensitive data
gem 'figaro', '1.0'
# cross domain requests
gem 'rack-cors', require: 'rack/cors'
# chart events
gem 'chartkick'
# chart events over time
gem 'groupdate'
# in development chart events over time using this
gem 'dateslices'
