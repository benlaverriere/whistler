# frozen_string_literal: true

class Card
  SUITS = %i[clubs hearts spades diamonds].freeze
  PIPS = %i[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  DISPLAY_SUITS = {
    clubs: ':clubs:',
    hearts: ':hearts:',
    spades: ':spades:',
    diamonds: ':diamonds:'
  }.freeze

  @@suit_values = Hash[SUITS.each_with_index.to_a]
  @@pip_values = Hash[PIPS.each_with_index.to_a]

  attr_reader :pip, :suit

  def initialize(pip, suit)
    @pip = pip
    @suit = suit
  end

  def <=>(other)
    (@@suit_values[@suit] <=> @@suit_values[other.suit]).nonzero? ||
      @@pip_values[@pip] <=> @@pip_values[other.pip]
  end

  def to_s
    "#{@display_suits[@suit]}#{@pip}"
  end
end

class Deck
  def initialize
    @cards = Card::PIPS.product(Card::SUITS).map do |pip, suit|
      Card.new(pip, suit)
    end.freeze
  end

  def length
    @cards.length
  end

  def shuffle
    @cards.shuffle
  end

  def self.group_by_suit(cards)
    cards.sort.group_by(&:suit).map do |k, v|
      "#{Card::DISPLAY_SUITS[k]} `#{v.map(&:pip).join(' ')}`"
    end
  end
end
