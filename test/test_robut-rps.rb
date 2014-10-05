require 'test_helper'
require 'robut'
require 'robut-rps'
require 'mocha/setup'

#random() = 0 -> "rock"
#           1 -> "paper"
#           2 -> "scissors"

class Robut::Plugin::RockPaperScissorsTest < Test::Unit::TestCase

  def setup
    @connection = Robut::ConnectionMock.new
    @presence = Robut::PresenceMock.new(@connection)
    @plugin = Robut::Plugin::RockPaperScissors.new(@presence)
  end

  def test_handle_rps_no_robut
    @plugin.stubs(:random).returns(1)
    @plugin.handle(Time.now, "John", "rps rock")
    assert_equal( [], @plugin.reply_to.replies )
  end

  def test_handle_rps_no_guess
    @plugin.stubs(:random).returns(1)
    @plugin.handle(Time.now, "John", "@robut rps")
    assert_equal( [], @plugin.reply_to.replies )
  end

  def test_handle_rps_invalid_guess
    @plugin.stubs(:random).returns(1)
    @plugin.handle(Time.now, "John", "@robut rps this isn't valid")
    assert_equal( [], @plugin.reply_to.replies )
  end

  def test_handle_rps_tie_rock
    @plugin.stubs(:random).returns(0)
    @plugin.handle(Time.now, "John", "@robut rps rock")
    assert_equal( ["We both threw rock. It's a tie!"], @plugin.reply_to.replies )
  end

  def test_handle_rps_tie_paper
    @plugin.stubs(:random).returns(1)
    @plugin.handle(Time.now, "John", "@robut rps paper")
    assert_equal( ["We both threw paper. It's a tie!"], @plugin.reply_to.replies )
  end

  def test_handle_rps_tie_scissors
    @plugin.stubs(:random).returns(2)
    @plugin.handle(Time.now, "John", "@robut rps scissors")
    assert_equal( ["We both threw scissors. It's a tie!"], @plugin.reply_to.replies )
  end

  def test_handle_rps_lose_rock_paper
    @plugin.stubs(:random).returns(1)
    @plugin.handle(Time.now, "John", "@robut rps rock")
    assert_equal( ["I threw paper which beats rock. You lose!"], @plugin.reply_to.replies )
  end

  def test_handle_rps_win_rock_paper
    @plugin.stubs(:random).returns(0)
    @plugin.handle(Time.now, "John", "@robut rps paper")
    assert_equal( ["You threw paper which beats rock. You win!"], @plugin.reply_to.replies )
  end
end