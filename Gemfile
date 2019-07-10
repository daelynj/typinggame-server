source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '~> 1.3'
gem 'hanami-model', '~> 1.3'
gem 'rubocop'
gem 'prettier'
gem 'pry'
gem 'iodine'
gem 'httparty'

gem 'pg'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun', platforms: :ruby
  gem 'hanami-webconsole'
end

group :test, :development do
  gem 'dotenv', '~> 2.4'
end

group :test do
  gem 'database_cleaner'
  gem 'rspec'
  gem 'capybara'
end

group :production do
  # gem 'puma'
end
