class Upcloudify
  module Notifiers
    class Slack
      require "httparty"

      def initialize(to: nil, url:)
        @url = url
        @to = to
      end

      def notify(text: nil)
        HTTParty.post(
          @url,
          headers: {"Content-Type" => content_type},
          body: payload.merge(text: text).to_json
        )
      end

      def payload
        { channel: @to }
      end

      private

      def content_type
        "application/json"
      end
    end
  end
end