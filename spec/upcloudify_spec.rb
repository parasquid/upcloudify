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

describe Upcloudify do
  describe ".upload_and_notify" do
    Given(:test_file_class) {
      class TestFile
        def url(expiration)
          "filename link"
        end
      end
      TestFile
    }
    Given(:test_file) { test_file_class.new }
    Given(:uploader) { double("uploader") }
    Given { allow(uploader).to receive(:upload).and_return(test_file) }
    Given(:notifier) { double("notifier") }
    Given(:klass) { Upcloudify }
    Given(:instance) { klass.new(uploader: uploader, notifier: notifier) }
    context "notifications" do
      Given { expect(uploader).to receive(:upload) }
      context "notifies the user" do
        When { expect(notifier).to receive(:notify) }
        Then {
          expect {
            instance.upload_and_notify(filename: 'abc', attachment: '123')
          }.not_to raise_error
        }
      end
      context "the notification has a custom message" do
        When { expect(notifier).to receive(:notify).with({text: "hi"}) }
        Then {
          expect {
            instance.upload_and_notify(filename: 'abc', attachment: '123', message: "hi")
          }.not_to raise_error
        }
      end
      context "the notification can merge the file url" do
        When { expect(notifier).to receive(:notify).with({text: "your report <filename link>"}) }
        Then {
          expect {
            instance.upload_and_notify(filename: 'abc', attachment: '123', message: "your report <%s>")
          }.not_to raise_error
        }
      end
    end
    context "uploads the file" do
      Given { allow(notifier).to receive(:notify) }
      When { expect(uploader).to receive(:upload) }
      Then {
        expect {
          instance.upload_and_notify(filename: 'abc', attachment: '123')
        }.not_to raise_error
      }
    end
  end

end