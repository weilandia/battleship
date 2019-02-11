class Battleship::Player::Computer < Battleship::Player
  private

  def place_ships
    ships.each do |ship|
      placement_coordinates = Battleship::RandomShipPlacementFinder.call(ship: ship, board: board)
      raise BoardSetupError if placement_coordinates.nil?

      board.place_ship(ship: ship, coordinates: placement_coordinates)
    end

    puts post_setup_message
  end

  private

    def post_setup_message
      "I have laid out my ships on the grid.\n\n"
    end
end
