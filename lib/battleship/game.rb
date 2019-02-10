class Battleship::Game
  def play
    puts "Welcome to BATTLESHIP\n"
    return unless start_game?

    attacking_player, waiting_player = [Battleship::Player::Computer.new, Battleship::Player::Human.new]

    until attacking_player.lost?
      attacking_player.take_turn
      attacking_player, waiting_player = [waiting_player, attacking_player]
    end

    waiting_player.is_a?(Battleship::Player::Computer) ? (puts "You lost.") : (puts "You won!")
  end

  private

    def start_game?
      puts "Enter p to play. Enter q to quit."
      gets.chomp == "p"
    end
end
