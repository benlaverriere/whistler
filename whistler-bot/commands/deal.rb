# frozen_string_literal: true

require_relative 'deck'

module WhistlerBot
  module Commands
    class Deal < SlackRubyBot::Commands::Base

      @deck = Deck.new

      def self.missing_participants
        'Please mention the other players I should deal to, '\
        'like `deal @robin @kelly @mariel`'
      end

      def self.mention_user(user_id)
        mention_thing(user_id, '@')
      end

      def self.mention_channel(channel_id)
        mention_thing(channel_id, '#')
      end

      def self.mention_thing(thing_id, prefix)
        "<#{prefix}#{thing_id}>"
      end

      def self.deal_to(user_ids)
        users = user_ids.map do |user|
          mention_user(user)
        end.join(', ')
        ":black_joker: Dealing a new round to #{users}"
      end

      def self.announce_hand(channel, dealer, cards)
        <<~REMARK
          #{mention_user(dealer)} wants to play cards with you in #{mention_channel(channel)}! Your hand is:
          #{sort_for_display(cards)}
        REMARK
      end

      def self.sort_for_display(cards)
        Deck.group_by_suit(cards).join("\n")
      end

      command 'deal' do |client, data, match|
        wc = client.web_client

        participants = participants(match['expression'])
        if participants.nil?
          client.say(
            channel: data.channel,
            text: missing_participants
          ) && return
        end

        participants += data.user unless participants.include? data.user
        client.say(channel: data.channel, text: deal_to(participants))

        dealt_hands = @deck.shuffle.each_slice(@deck.length / participants.length)
        participants.each do |user_id|
          im = wc.im_open(user: user_id)
          wc.chat_postMessage(
            channel: im['channel']['id'],
            text: announce_hand(data.channel, data.user, dealt_hands.first),
            as_user: true
          )
        end
      end

      def self.participants(expression)
        /<@(\w+?)>/.match(expression)&.captures
      end
    end
  end
end
