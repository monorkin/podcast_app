source "https://rubygems.org"

ruby ">= 3"

gem "bcrypt", "~> 3.1.7"
gem "bootsnap", require: false
gem "good_job"
gem "importmap-rails"
gem "jbuilder"
gem "pg", "~> 1.1"
gem "propshaft"
gem "puma", ">= 5.0"
gem "rails", "~> 7.1.0.beta1"
gem "rss", github: "monorkin/ruby-rss", branch: "feature/podcast-support"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
  gem "memory_profiler"
  gem "rack-mini-profiler"
  gem "stackprof"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webmock"
end
