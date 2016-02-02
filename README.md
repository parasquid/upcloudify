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
Upcloudify::S3.configure do |config|
  config.aws_secret_access_key = 'foobarbaz' # can also be ENV['AWS_SECRET_ACCESS_KEY']
  config.aws_access_key_id  = 'hello' # can also be ENV['AWS_ACCESS_KEY_ID']
  config.aws_directory = 'aws-directory'
end
```

Then, anywhere you want to upload a file and email a link:

``` ruby
uploader.email(params["email"], params["file"]["filename"], params["file"]["tempfile"])
```

You can also pass in an options hash to further customize the email links:
``` ruby
  options = {
    suffix: " generated on #{Time.now.to_s}",
    expiration: Time.now.tomorrow,
    from: 'upcloudify',
    subject: 'your file is attached',
    body: 'your report is linked '
  }
```

## Sample App

There's a sample Sinatra app in the sample_app directory of this gem. To run:

``` bash
bundle exec ruby sample.rb
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Don't forget tests!
6. Create new Pull Request
