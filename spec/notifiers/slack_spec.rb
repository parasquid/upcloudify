require "notifiers/slack"

describe Upcloudify::Notifiers::Slack do
  Given(:recipient_1) { "@parasquid" }
  Given(:recipient_2) { "#general" }
  Given(:klass) { Upcloudify::Notifiers::Slack }
  context "sanity check" do
    Given(:token) { "token" }
    When(:instance) { klass.new(to: [recipient_1, recipient_2], token: token) }
    Then { instance != nil }
  end

  Given(:instance) { klass.new(to: [recipient_1, recipient_2], token: token) }
  context "sends slack a notification" do
    When { instance.notify }
  end
end