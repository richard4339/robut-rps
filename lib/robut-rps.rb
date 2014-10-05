require 'calc'

# Rock Paper Scissors
class Robut::Plugin::RockPaperScissors
  include Robut::Plugin

  def usage
    ["#{at_nick} rps <rock|paper|scissors>"]
  end

  def handle(time, sender_nick, message)
    if sent_to_me?(message)
      words = words(message)

      return unless words[0] == "rps" && (words[1] == "rock" || words[1] == "scissors" || words[1] == "paper")

      answers = ["rock",
                 "paper",
                 "scissors"]
      choice = answers[random(answers.length)]

      if choice == words[1]
        reply "We both threw #{choice}. It's a tie!"
        return
      end

      win = false
      win = true if choice == "rock" && words[1] == "paper"
      win = true if choice == "paper" && words[1] == "scissors"
      win = true if choice == "scissors" && words[1] == "rock"
      reply("You threw #{words[1]} which beats #{choice}. You win!") if win
      reply("I threw #{choice} which beats #{words[1]}. You lose!") unless win

    end

  end

  def random(c)
    rand(c)
  end
end