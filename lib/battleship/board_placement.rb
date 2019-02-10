class Battleship::BoardPlacement
  attr_reader :ship, :cells, :rows, :columns

  def initialize(ship:, cells:)
    @ship = ship
    @cells = cells
    @rows, @columns = Battleship::Cell.to_rows_and_columns(cells: cells)
  end

  def valid?
    return false if ship.length != cells.length
    return false unless cells.all?(&:empty?)
    return true if valid_horizontal_placement?(rows: rows, columns: columns)
    valid_vertical_placement?(rows: rows, columns: columns)
  end

  private

    def valid_horizontal_placement?(rows:, columns:)
      valid_placement?(constants: rows, increments: columns)
    end

    def valid_vertical_placement?(rows:, columns:)
      valid_placement?(constants: columns, increments: rows)
    end

    def valid_placement?(constants:, increments:)
      return false if constants.keys.uniq.length != 1
      Battleship::Cell.increments?(cells: increments.values.flatten)
    end
end
