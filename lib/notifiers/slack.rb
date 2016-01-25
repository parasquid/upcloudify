module Upcloudify
  module Notifiers
    class Slack
      require "httparty"

      def initialize(to:, url:)
        @url = url
      end

      def notify
        HTTParty.post(@url, headers: {"Content-Type" => content_type})
      end

      private

      def content_type
        "application/json"
      end
    end
  end
end