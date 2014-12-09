# Upcloudify

Upcloudify simplifies the process for uploading attachments to the cloud and emailing the recipient a link to that attachment.

## Installation

Add this line to your application's Gemfile:

    gem 'upcloudify'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install upcloudify

## Usage

Configure the app:

``` ruby
# config/initializers/awesomeness.rb
Upcloudify.configure do |config|
  config.aws_secret_access_key = 'foobarbaz' # can also be ENV['AWS_SECRET_ACCESS_KEY']
  config.aws_access_key_id  = 'hello' # can also be ENV['AWS_ACCESS_KEY_ID']
  config.aws_directory = 'aws-directory'
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
