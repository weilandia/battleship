class Battleship::Player::Computer < Battleship::Player
  attr_accessor :radar

  def take_turn
    puts "=============OPPONENT TURN============="

    if radar
      coordinate = radar[:targets].pop
      cell = opponent.board.cells[coordinate] || valid_targets.sample
    else
      cell = valid_targets.sample
    end

    attack(cell: cell)
    calibrate_radar(cell: cell)

    puts "My #{cell.render_attack_result}"
  end

  private

    def calibrate_radar(cell:)
      return if cell.empty?
      return clear_radar if cell.ship.sunk?

      self.radar = { hits: [], targets: [] } if radar.nil?
      radar[:hits] << cell
      radar[:targets] = get_targets(hits: radar[:hits])
    end

    def clear_radar
      self.radar = nil
    end

    def get_targets(hits:)
      if hits.length == 1
        get_perimeter(cell: hits[0])
      else
        get_adjacent(cells: hits)
      end
    end

    def get_perimeter(cell:)
      row, column = cell.to_ints

      perimeter = [[1, 0], [-1, 0], [0, 1], [0, -1]].map do |(shift_x, shift_y)|
        [row + shift_y, column + shift_x]
      end

      perimeter_coordinates = Battleship::Cell.transform_coord_ints(coord_ints: perimeter)
      perimeter_coordinates.select do |coordinate|
        opponent.board.valid_coordinate?(coordinate: coordinate) && opponent.board.cells[coordinate].safe?
      end
    end

    def get_adjacent(cells:)
      coordinates = cells.map(&:to_ints)

      if coordinates.map(&:last).uniq.length == 1
        increment = coordinates.map(&:first).sort
        column = coordinates[0][1]
        targets = [[increment[0] - 1, column], [increment[-1] + 1, column]]
      else
        increment = coordinates.map(&:last).sort
        row = coordinates[0][0]
        targets = [[row, increment[0] - 1], [row, increment[-1] + 1]]
      end

      adjacent_coordinates = Battleship::Cell.transform_coord_ints(coord_ints: targets)

      adjacent_coordinates.select do |coordinate|
        opponent.board.valid_coordinate?(coordinate: coordinate) && opponent.board.cells[coordinate].safe?
      end
    end

    def place_ships
      ships.each do |ship|
        placement_coordinates = Battleship::RandomShipPlacementFinder.call(ship: ship, board: board)
        raise BoardSetupError if placement_coordinates.nil?

        board.place_ship(ship: ship, coordinates: placement_coordinates)
      end

      puts post_setup_message
    end

    def post_setup_message
      "I have laid out my ships on the grid.\n\n"
    end
end
