class Battleship::RandomShipPlacementFinder
  def self.call(board:, ship:)
    new(board: board, ship: ship).random_coord
  end

  attr_reader :board, :ship, :initial_x, :initial_y

  def initialize(board:, ship:)
    @board = board
    @ship = ship
    @initial_x, @initial_y = ["A".ord, 1].shuffle
  end

  def random_coord
    valid_options_on_axis.sample
  end

  private

    def valid_options_on_axis
      valid_x_range.each_with_object([]) do |start_x, valid_coords|
        initial_y.upto(initial_y - 1 + board.size) do |y|
          coord_ints = range_by_length(start_x, ship.length).map { |x| rotate_axes([x, y]) }
          coords = transform_coord_ints(coord_ints)

          if board.valid_placement?(ship: ship, coordinates: coords)
            valid_coords << coords
          end
        end
      end
    end

    def valid_x_range
      range_by_length(initial_x, board.size - ship.length + 1)
    end

    def transform_coord_ints(coord_ints)
      coord_ints.map { |coord_ints| [coord_ints[0].chr, coord_ints[1]].join }
    end

    def rotate_axes(coords)
      coords.sort.reverse
    end

    def range_by_length(start, length)
      start..(start + (length - 1))
    end
end
