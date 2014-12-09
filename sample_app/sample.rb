require 'sinatra'
require 'pry'
require 'upcloudify'
require 'active_support/all'

enable :sessions

get '/' do
  erb :index
end

post '/upload' do
  Upcloudify.configure do |config|
    config.aws_access_key_id  = params["s3_id"]
    config.aws_secret_access_key = params["s3_key"]
    config.aws_directory = params["s3_directory"]
  end

  uploader = Upcloudify::S3.new

  uploader.email(params["email"], params["file"]["filename"], params["file"]["tempfile"])
  # redirect '/'
end