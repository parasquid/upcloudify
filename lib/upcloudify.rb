require "upcloudify/version"

module Upcloudify
  include GemConfig::Base
  require 'zip/zip'

  with_configuration do
    has :aws_secret_access_key, default: ENV['AWS_SECRET_ACCESS_KEY']
    has :aws_access_key_id, default: ENV['AWS_ACCESS_KEY_ID']
    has :aws_directory
  end

  class S3

    # Internal: Connects to Amazon S3 using sored credentials
    # Returns an object handle for the S3 bucket-directory
    def cloud
      connection = Fog::Storage.new(
        :provider                 => 'AWS',
        :aws_secret_access_key    => Upcloudify.configuration.aws_secret_access_key,
        :aws_access_key_id        => Upcloudify.configuration.aws_access_key_id,
      )
      directory = connection.directories.get(Upcloudify.configuration.aws_directory)
      directory.files
    end

    # Internal: Uploads data into Amazon S3
    # Returns an object representing the uploaded file
    def upload(filename, data)
      file = cloud.create(
        key: "#{filename}.zip",
        body: Zippy.new("#{filename}.csv" => data).data,
        :public => false
      )
      file
    end

    # Public: Uploads a file to S3 and emails a link to the file.
    # Returns nothing.
    def email(email,
      filename,
      attachment,
      options={suffix: " generated on #{Time.now.to_s}",
        expiration: Time.now.next_month.end_of_month,
        from: 'upcloudify',
        subject: 'your file is attached',
        body: 'your report is linked '})
      
      suffix = options[:suffix]
      expiration = options[:expiration]
      file = upload((filename.to_s + suffix.to_s).parameterize, attachment)

      Pony.mail to: email,
        from: options[:from],
        subject: options[:subject],
        body: options[:body] + file.url(expiration)

    end

  end

end
