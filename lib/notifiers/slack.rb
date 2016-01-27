class Upcloudify
  module Notifiers
    class Slack
      require "httparty"

      def initialize(to: nil, url:, text: "hello!")
        @url = url
        @text = text
        @to = to
      end

      def notify
        HTTParty.post(
          @url,
          headers: {"Content-Type" => content_type},
          body: payload.to_json
        )
      end

      def payload
        { text: @text, channel: @to }
      end

      private

      def content_type
        "application/json"
      end
    end
  end
end