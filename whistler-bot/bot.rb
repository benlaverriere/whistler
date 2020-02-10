# frozen_string_literal: true

module WhistlerBot
  class Bot < SlackRubyBot::Bot
    help do
      title 'Whistler'
      desc \
        'Whistler wants to help you play cards with your friends, when your'\
        "friends aren't all at the same table."

      command 'deal <users...>' do
        desc 'Deal a 52-card deck evenly among the specified users.'
        long_desc \
          "Specify the users you'd like to play with by mentioning them, like"\
          "`deal @robin @kelly @mariel`. You don't need to include your own name."
      end
    end
  end
end
