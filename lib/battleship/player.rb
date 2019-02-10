class Battleship::Player
  attr_reader :board, :ships

  def initialize
    @board = Battleship::Board.new
    @ships = [Battleship::Ship::Cruiser.new, Battleship::Ship::Submarine.new]

    place_ships
  end

  def lost?
    ships.all(&:sunk)
  end
end
