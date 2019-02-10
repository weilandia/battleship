class Battleship::Player
  attr_reader :board, :ships

  def initialize
    @board = Board.new
    @ships = [Cruiser.new, Submarine.new]

    place_ships
  end

  def lost?
    ships.all(&:sunk)
  end
end
