source "http://rubygems.org"

# The gem's dependencies are specified in gir_ffi.gemspec
gemspec

unless ENV["CI"]
  gem 'pry', require: false
  if RUBY_ENGINE == 'ruby'
    gem 'simplecov', require: false
  end
end
