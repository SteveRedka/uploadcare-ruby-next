# Ruby integration for Uploadcare

<p align="left">
    <a href="LICENSE">
        <img src="https://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
    </a>
</p>

Uploadcare Ruby integration handles uploads and further operations with files by
wrapping Upload and REST APIs.

* [Installation](#installation)
* [Usage](#usage)
* [Development](#development)
* [Useful links](#useful-links)

## Installation

Create your project in [Uploadcare dashboard](https://uploadcare.com/dashboard/)
and copy its API keys from there.

Set your Uploadcare keys in config file or through environment variables
`UPLOADCARE_PUBLIC_KEY` and `UPLOADCARE_SECRET_KEY`

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

#### Service

Objects that don't fit any pattern

## Useful links

[Uploadcare documentation](https://uploadcare.com/docs/)  
[Upload API reference](https://uploadcare.com/api-refs/upload-api/)  
[REST API reference](https://uploadcare.com/api-refs/rest-api/)  
[Changelog](/CHANGELOG.md)  
[Contributing guide](https://github.com/uploadcare/.github/blob/master/CONTRIBUTING.md)  
[Security policy](https://github.com/uploadcare/uploadcare-ruby/security/policy)  
[Support](https://github.com/uploadcare/.github/blob/master/SUPPORT.md)  
