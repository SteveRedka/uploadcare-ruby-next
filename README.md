# Uploadcare::Ruby

Ruby wrapper for Uploadcare API

## Installation
Set your Uploadcare keys. You can do it either in config file, or through
environment variables `UPLOADCARE_PUBLIC_KEY` and `UPLOADCARE_SECRET_KEY`

```ruby
# config/uploadcare/uploadcare_configuration.rb

require 'uploadcare'

Uploadcare.configure do |config|
  config.public_key = ENV.fetch('UPLOADCARE_PUBLIC_KEY')
  config.secret_key = ENV.fetch('UPLOADCARE_SECRET_KEY')
end
```

Add this line to your application's Gemfile:

```ruby
gem 'uploadcare-ruby'
```

And then execute:

    $ bundle

## Usage

## Development
### Docs
https://uploadcare.com/docs/api_reference/
https://uploadcare.com/api-refs/rest-api/

### Architecture
Project uses [ApiStruct](https://github.com/rubygarage/api_struct) architecture.
#### Uploadcare.configuration.rb
This file lists used endpoints and their defaults
#### Client
This layer contains services that interact with API endpoints, and handles different specifics of talking to different APIs (such as: different headers, encryptions, params, etc..)
#### Entity
This layer contains serializers of API endpoints
#### Header
This folder contains anything related to unusual headers
#### Resource
This folder contains objects representing objects as they exist in Uploadcare cloud; think ActiveRecord model
#### Service
Objects that don't fit any pattern

-----

## Contributing

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
