class Battleship::Player
  attr_accessor :opponent
  attr_reader :board, :ships

  def initialize
    @board = Battleship::Board.new
    @ships = [Battleship::Ship::Cruiser.new, Battleship::Ship::Submarine.new]

    place_ships
  end

  def attack(cell:)
    cell.tap(&:fire_upon)
  end

  def lost?
    ships.all?(&:sunk?)
  end

  def valid_targets
    opponent.board.safe_cells
  end
end
