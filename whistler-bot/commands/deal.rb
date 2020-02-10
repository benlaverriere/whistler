require 'pry'

module WhistlerBot
  module Commands
    class Deal < SlackRubyBot::Commands::Base
      @cards = %w[A 2 3 4 5 6 7 8 9 10 J Q K].product(%w[:clubs: :hearts: :spades: :diamonds:]).freeze
      command 'deal' do |client, data, _match|
        wc = client.web_client

        participants = data.blocks.first.elements.first.elements.select{|node| node.type == "user"}.map{|user| user.user_id }
        client.say(channel: data.channel, text: 'Please mention the other players I should deal to, like `deal @robin @kelly @mariel`') and return unless participants.length > 0
        participants += data.user unless participants.include? data.user
        client.say(channel: data.channel, text: ":black_joker: Dealing a new round to #{participants.map{|user_id| "<@#{user_id}>"}.join(", ")}")

        dealt_hands = @cards.shuffle.each_slice(@cards.length/participants.length)
        participants.each do |user_id|
          im = wc.im_open(user: user_id)
          wc.chat_postMessage(
            channel: im['channel']['id'],
            text: "<@#{data.user}> wants to play cards with you! Your hand is:\n#{dealt_hands.first.map{|card| card.reverse.join('')}.sort.join("\n")}",
            as_user: true)
        end
      end


      def participants(data)
        # TODO, clearly, some improvements
        data.blocks.first.elements.first.elements.select{|node| node.type == "user"}.map{|user| user.user_id }
      end

    end
  end
end
