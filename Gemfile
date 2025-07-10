source "https://rubygems.org"


gem "rails", "~> 8.0.2"
gem "lograge"
gem "propshaft"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "bcrypt", "~> 3.1"

# Oauth client for Google and other providers
gem "omniauth", "~> 2.1", ">= 2.1.2"
gem "omniauth-rails_csrf_protection", "~> 1.0", ">= 1.0.2"
gem "omniauth-google-oauth2", "~> 1.2"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  # gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "pry-nav"

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
end

group :development, :test do
  gem "awesome_print"
  gem "dotenv-rails", groups: [ :development, :test ]
  gem "factory_bot_rails"
  gem "minitest"
end

group :development do
  gem "better_errors"
  gem "annotate"
  gem "web-console"
  gem "binding_of_caller"
end
