class Battleship::BoardRenderer
  def self.call(rows:)
    new(rows: rows).render
  end

  attr_reader :rows, :show_hidden_ships

  def initialize(rows:, show_hidden_ships: false)
    @rows = rows
    @show_hidden_ships = show_hidden_ships
  end

  def render
    column_key_row + render_rows
  end

  private

    def column_count
      rows.first[1].length
    end

    def column_key_row
      "  #{1.upto(column_count).to_a.join(" ")}\n"
    end

    def render_rows
      rows.map do |row, cells|
        "#{row} #{Battleship::Cell.render(cells: cells, show_ship: show_hidden_ships)}\n"
      end.join("\n")
    end
end
