class Battleship::Cell
  attr_reader :coordinate
  attr_accessor :ship, :fired_upon

  def self.render(cells:, show_ship: false)
    cells.map { |cell| cell.render(show_ship: show_ship) }.join(" ")
  end

  def self.sort(cells:)
    cells.sort do |a, b|
      a_coord = a.coordinate
      b_coord = b.coordinate

      a_coord[0].ord + a_coord[1].to_i <=> b_coord[0].ord + b_coord[1].to_i
    end
  end

  def self.to_rows_and_columns(cells:)
    sorted_cells = sort(cells: cells)

    rows = sorted_cells.group_by { |cell| cell.coordinate[0] }
    columns = sorted_cells.group_by { |cell| cell.coordinate[1] }

    [rows, columns]
  end

  def self.increments?(cells:)
    cells.map do |cell|
      coordinate = cell.coordinate
      coordinate[0].ord + coordinate[1].to_i
    end.increments?
  end

  def self.safe?(cells:)
    cells.select(&:safe?)
  end

  def self.transform_coord_ints(coord_ints:)
    coord_ints.map { |coord_ints| [coord_ints[0].chr, coord_ints[1]].join }
  end

  def initialize(coordinate:)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    ship.nil?
  end

  def fire_upon
    ship&.hit
    self.fired_upon = true
  end

  def fired_upon?
    !!fired_upon
  end

  def safe?
    !fired_upon?
  end

  def place_ship(new_ship:)
    return false if ship
    self.ship = new_ship
  end

  def render(show_ship: false)
    return "S" if safe? && ship && show_ship
    return "." if safe?
    return "M" if empty?
    return "X" if ship.sunk?

    "H"
  end

  def render_attack_result
    return "shot on #{coordinate} was a miss." if empty?
    return "shot on #{coordinate} has sunk a ship." if ship.sunk?

    "shot on #{coordinate} has hit a ship."
  end

  def to_ints
    row, column = coordinate.split("")
    [row.ord, column.to_i]
  end
end
