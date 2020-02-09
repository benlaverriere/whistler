require 'spec_helper'

describe WhistlerBot::Commands::Deal do
  def app
    WhistlerBot::Bot.instance
  end

  subject { app }

  it 'includes each card once' do
    expect(message: "#{SlackRubyBot.config.user} deal", channel: 'channel').to respond_with_slack_message()
  end
end
