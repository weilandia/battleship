class Battleship::Board
  attr_reader :cells, :size, :rows, :columns

  def initialize(size: 4)
    @size = size
    @cells = build_cells
    @rows, @columns = Battleship::Cell.to_rows_and_columns(cells: cells.values)
  end

  def valid_coordinate?(coordinate:)
    !!cells[coordinate]
  end

  def valid_placement?(ship:, coordinates:)
    return false unless coordinates.all? { |coord| valid_coordinate?(coordinate: coord) }
    coordinate_cells = cells_from_coordinates(coordinates: coordinates)

    Battleship::BoardPlacement.new(ship: ship, cells: coordinate_cells).valid?
  end

  def place_ship(ship:, coordinates:)
    if valid_placement?(ship: ship, coordinates: coordinates)
      coordinate_cells = cells_from_coordinates(coordinates: coordinates)
      coordinate_cells.map { |cell| cell.place_ship(new_ship: ship) }
    end
  end

  def render(show: false)
    Battleship::BoardRenderer.call(rows: rows, show_hidden_ships: show)
  end

  private

    def coordinates
      @cells.keys
    end

    def cells_from_coordinates(coordinates:)
      coordinates.map { |coord| cells[coord] }
    end

    def cell_count
      size**2
    end

    def build_cells
      1.upto(cell_count).each_with_object({}) do |cell, cells|
        row = ((cell - 1) / size + 65).chr
        column = "#{cell % size + 1}"
        coordinate = "#{row}#{column}"

        cells["#{row}#{column}"] = Battleship::Cell.new(coordinate: coordinate)
      end
    end
end
