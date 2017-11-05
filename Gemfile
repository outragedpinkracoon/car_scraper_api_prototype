source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'

gem 'nokogiri', '~> 1.8.1'
gem 'sqlite3'

group :test do
  gem 'rspec-rails', '~> 3.6.1'
  gem 'spring-commands-rspec', '~> 1.0.4'
  gem 'vcr', '~> 3.0.3'
  gem 'webmock', '~> 3.0.1'
end

group :development, :test do
  gem 'byebug', '~> 9.1.0', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
