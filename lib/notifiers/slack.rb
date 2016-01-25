module Upcloudify
  module Notifiers
    class Slack
      require "httparty"

      def initialize(to:, url:)
        @url = url
      end

      def notify
        HTTParty.post(@url)
      end
    end
  end
end