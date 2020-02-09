module WhistlerBot
  module Commands
    class Deal < SlackRubyBot::Commands::Base
      @cards = %w[A 2 3 4 5 6 7 8 9 10 J Q K].product(%w[:clubs: :hearts: :spades: :diamonds:]).freeze
      command 'deal' do |client, data, _match|
        # see https://github.com/dblock/slack-strava/blob/d70e32939b76934943fc0fc7260454874b5b416c/slack-strava/models/user.rb#L39-L44
        # for some good examples of user lookup
        client.say(channel: data.channel, text: data.blocks)
        message = @cards.shuffle.flatten.each_slice(13)
        client.say(channel: data.channel, text: message.flatten)
      end
    end
  end
end
