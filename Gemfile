source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.4.4'

gem 'rails', '~> 8.1.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 7.2.1'
gem 'bootsnap', '>= 1.16.0', require: false
gem 'jsonapi-serializer'
gem 'csv'

group :test do
  gem 'simplecov', require: false
end

group :development, :test do
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 7.0'
  gem 'factory_bot_rails'
end

group :development do
  gem 'kamal', '~> 2.12'
  gem 'bundler-audit', require: false
  gem 'listen', '~> 3.9'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.1'
  gem 'annotate'
end
