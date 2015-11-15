require 'spec_helper'
require 'monkey_patches'

describe Time do
  context "tomorrow" do
    it 'gives the time for tomorrow' do
      time_now = Time.now
      expect(time_now.tomorrow).to be_within(0.0001).of(Time.at(time_now.to_f + 86400))
    end
  end
end