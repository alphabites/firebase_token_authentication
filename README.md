# Firebase Token Authentication

A light weight Firebase access token validator which utilizes HTTP caching to reduce network traffic when validating against Google's X509 Certificates.

The goal of this project was to create a reusable, light weight, non-rails dependent library to validate [Firebase Authentication](https://firebase.google.com/docs/auth) access tokens which could utilize an efficient cache without a required external dependency, like Redis. Moreover I wanted a solution flexible enough to host on Heroku which could safely survive dyno refreshes. After a dyno refreshes, on each dyno, the first call to fetch the Google X509 certs will go over the network, but from then on be cached.

Underneath we are using the [ruby-jwt](https://github.com/jwt/ruby-jwt) gem to decode the access token. If the token does not decode properly it will raise an exception. We wrap the exception inside a `FirebaseTokenAuthentication::Error` to help differentiate between your application's own JWT implementation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'firebase_token_authentication'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install firebase_token_authentication

## Usage

### Configuration

```ruby
# config/initializers/firebase_token_authentication.rb

FirebaseTokenAuthentication.configure do |config|
  # Your Firebase Project ID
  config.firebase_project_id = ENV['firebase_project_id']

  # An optional cache store to persist X509 Certificates
  config.cache_store = CacheStore.new

  # An optional logger hook to view cache status
  config.logger = Logger.new(STDOUT)
end
```

### Cache Store

The gem uses [Faraday](https://github.com/lostisland/faraday) with the [faraday-http-cache](https://github.com/sourcelevel/faraday-http-cache) middleware gem to manage the cache.

Any cache object that responds to `write(key, value)`, `read(key)`, and `delete(key)` is a valid cache store. To that extent you could roll your own cache store quite easily.

A very rough, but easy to understand, example with a plain ol' ruby object:

```ruby
class CacheStore
  def write(key, value)
    store[key] = value
  end

  def read(key)
    store[key]
  end

  def delete(key)
    store.delete(key)
    store
  end

  def store
    @store ||= {}
  end
end
```

#### Rails Cache

The [Rails.cache](https://guides.rubyonrails.org/caching_with_rails.html) is a valid cache store. As a reminder though it is disabled in Development and Test environments and has many different config options. I recommend you review [the docs](https://guides.rubyonrails.org/caching_with_rails.html).

### Logger

The `config.logger` allows you to view the status of the cache. An example of a log:

`HTTP Cache: [GET /robot/v1/metadata/x509/securetoken@system.gserviceaccount.com] fresh`

Pulled directly from the [faraday-http-cache](https://github.com/sourcelevel/faraday-http-cache) docs, the keys represent the following:

- `:unacceptable` means that the request did not go through the cache at all.
- `:miss` means that no cached response could be found.
- `:invalid` means that the cached response could not be validated against the server.
- `:valid` means that the cached response could be validated against the server.
- `:fresh` means that the cached response was still fresh and could be returned without even calling the server.

## Development

### TODOs

- [ ] Complete the test suite
- [ ] Class and method documentation
- [ ] Add support for non shared cache [RFC 2616 Shared and Non-Shared Caches](https://datatracker.ietf.org/doc/html/rfc2616#section-13.7) which seems simple [with this config](https://github.com/sourcelevel/faraday-http-cache#shared-vs-non-shared-caches).

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alphabites/firebase_auth. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/alphabites/firebase_auth/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FirebaseAuth project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/firebase_auth/blob/main/CODE_OF_CONDUCT.md).
