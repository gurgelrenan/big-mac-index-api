source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'jsonapi-serializer'

group :test do
  gem 'simplecov', require: false
end

group :development, :test do
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 4.0.0'
  gem 'factory_bot_rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'annotate'
end