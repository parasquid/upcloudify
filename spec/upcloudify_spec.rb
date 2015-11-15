require 'spec_helper.rb'
require 'pry'
require 'upcloudify'

describe Upcloudify::S3 do
  context 'sanity check' do
    subject { Upcloudify::S3.new(
        aws_secret_access_key: 'test_key',
        aws_access_key_id: 'test_id',
        aws_directory: 'test_directory'
      )
    }

    it 'instantiates an object' do
      expect(subject).to_not be nil
    end

    it 'raises an error when the arguments are missing' do
      expect { subject.email }.to raise_error(ArgumentError)
    end
  end

  context 'email' do
    subject { Upcloudify::S3.new(
        aws_secret_access_key: 'test_key',
        aws_access_key_id: 'test_id',
        aws_directory: 'test_directory'
      )
    }

    # TODO: we should probably create an object that has this interface and mock that
    let(:connection) { double("connection") }
    let(:directories) { double("directories") }
    let(:directory) { double("directory") }
    let(:files) { double("files") }

    before :each do
      allow(connection).to receive(:directories).and_return(directories)
      allow(directories).to receive(:get).and_return(directory)
      allow(directory).to receive(:files).and_return(files)
    end

    it 'connects to the cloud service and returns the files in the configured directory' do
      expect(subject.cloud(connection)).to eq files
    end
  end
end