module Upcloudify
  module Notifiers
    class Slack
      require "httparty"

      def initialize(to:, url:, text: "hello!", username: "upcloudify")
        @url = url
        @text = text
      end

      def notify
        HTTParty.post(
          @url,
          headers: {"Content-Type" => content_type},
          body: payload.to_json
        )
      end

      def payload
        { text: @text }
      end

      private

      def content_type
        "application/json"
      end
    end
  end
end