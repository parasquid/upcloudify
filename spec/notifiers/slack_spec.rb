require "notifiers/slack"

describe Upcloudify::Notifiers::Slack do
  Given(:recipient) { "@parasquid" }
  Given(:klass) { Upcloudify::Notifiers::Slack }
  Given(:slack_api_url) { "https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX"}
  context "sanity check" do
    Given(:token) { "token" }
    When(:instance) { klass.new(to: recipient, url: slack_api_url) }
    Then { instance != nil }
  end

  Given(:instance) { klass.new(to: recipient, url: slack_api_url) }
  describe "slack endpoint connectivity" do
    context "a connection is made to the slack server" do
      Given!(:slack_api_stub) { stub_request(:post, slack_api_url) }
      When { instance.notify }
      Then { expect(slack_api_stub).to have_been_requested }
    end

    context "the content type is application/json" do
      Given!(:slack_api_stub) {
        stub_request(:post, slack_api_url).
          with(headers: {"Content-Type" => "application/json"})
      }
      When { instance.notify }
      Then { expect(slack_api_stub).to have_been_requested }
    end
  end

  describe "payload" do
    Given(:instance) { klass.new(to: recipient, url: slack_api_url, text: "abc") }
    context "the payload contains the text" do
      When(:payload) { instance.payload }
      Then { expect(payload).to include(text: "abc") }
    end

    context "the payload contains the username to be notified" do
      When(:payload) { instance.payload }
      Then { expect(payload).to include(channel: recipient) }
    end
  end
end