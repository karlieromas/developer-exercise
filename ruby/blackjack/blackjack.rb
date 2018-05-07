class Card
  attr_accessor :suite, :name, :value

  def initialize(suite, name, value)
    @suite, @name, @value = suite, name, value
  end
end

class Deck
  attr_accessor :playable_cards
  SUITES = [:hearts, :diamonds, :spades, :clubs]
  NAME_VALUES = {
    :two   => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 10,
    :queen => 10,
    :king  => 10,
  :ace   => [11, 1]}

  def initialize
    shuffle
  end
  # this used to be called 'deal_card'
  # now this is called draw to only get 1 card
  def draw
    random = rand(@playable_cards.size)
    @playable_cards.delete_at(random)
  end
  # this is to start the game, always drawing 2 cards
  def deal_cards
    2.times { hand.cards << draw }
    hand
  end

  def shuffle
    @playable_cards = []
    SUITES.each do |suite|
      NAME_VALUES.each do |name, value|
        @playable_cards << Card.new(suite, name, value)
      end
    end
  end

end

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def number_of_cards
    @cards.length
  end

  def total_hand
    @cards.map { |card| card[:value] }.reduce(:+)
  end



  #   card_value_total = @cards.map { |card| card[:value] }.reduce(:+)
  #   if total_player > 21
  #     puts 'player bust'
  #   elsif total_player == 21
  #     puts 'blackjack!'
  #   else
  #     @cards
  #   end
  # end


end

class Player
  # should we instantiate a dealer since we need one to have a game?
  #  should we instantiate a deck here since we need to be able to 'hit' or in this case use the 'draw' method from the deck class
  def initialize
    @hand = Hand.new
  end

  def total_player
    @hand.cards.map { |card| card[:value] }.reduce(:+)
  end

  def total_dealer
    total_self
  end

  def hit
    draw
  end

  # immediate blackjack
  # have to map through the cards array (which is an array of card objects) and get the value of total hand - which we have the player class. if over 21, bust, if equals 21, win!
  # idea
  # def blackjack?
  #   if total_player == 21
  #     true
  #   else
  #     @cards
  #   end
  # end

end

class Dealer

  def initialize
    @player = Player.new
    @hand = Hand.new
    @deck = Deck.new
  end

  def deal_self
    deal_cards
  end

  def show_second_card
    @cards[1][:value]
  end

  def deal_player
    @player.hand << @deck.deal_cards
  end

  def total_self
    @hand.cards.map { |card| card[:value] }.reduce(:+)
  end

  def total_player
    @player.hand.cards.map {card| card[:value] }.reduce(:+)
  end

  def hit_self
    @hand.cards << @deck.draw
  end

  # dealer needs to hit if dealt hand is below 17, but must stay if he has 17 or higher

  # def dealer_hits
  #   if total_self < 17
  #     until total_self >= 17
  #       draw
  #     end
  #   elsif
  #     total_self > total_player && total_self >= 17
  #     puts 'dealer wins'
  #   else
  #     puts 'player wins'
  #   end
  # end

end



require 'test/unit'

class CardTest < Test::Unit::TestCase
  def setup
    @card = Card.new(:hearts, :ten, 10)
  end

  def test_card_suite_is_correct
    assert_equal @card.suite, :hearts
  end

  def test_card_name_is_correct
    assert_equal @card.name, :ten
  end
  def test_card_value_is_correct
    assert_equal @card.value, 10
  end
end

class DeckTest < Test::Unit::TestCase
  def setup
    @deck = Deck.new
  end

  def test_new_deck_has_52_playable_cards
    assert_equal @deck.playable_cards.size, 52
  end

  def test_dealt_card_should_not_be_included_in_playable_cards
    card = @deck.deal_cards
    assert_equal(@deck.playable_cards.include?(card), false)
  end

  def test_shuffled_deck_has_52_playable_cards
    @deck.shuffle
    assert_equal @deck.playable_cards.size, 52
  end

  # def test_player_dealt_two_cards
  #   hand = @deck.deal_player
  #   assert_equal hand.cards.count, 2
  # end

  def test_dealer_dealt_two_cards
    hand = @deck.deal_player
    assert_equal hand.cards.count, 2
  end

end

class HandTest < Test::Unit::TestCase

  def setup
    @hand = Hand.new
    @deck = Deck.new
  end

  # def test_player_deal_count
  #   @hand.cards
  # end


end

class PlayerTest < Test::Unit::TestCase

  def setup
    @player = Player.new
    @deck = Deck.new
    # @hand = Hand.new
  end


end

class DealerTest < Test::Unit::TestCase

  def setup
    @player = Player.new
    @deck = Deck.new
    @hand = Hand.new
  end

  def test_player_dealt_two_cards
    hand = @player.deal_player
    assert_equal hand.cards.count, 2
  end
end
