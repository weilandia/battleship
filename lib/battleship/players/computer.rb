class Battleship::Player::Computer < Battleship::Player
  private

    def place_ships
      ships.each do |ship|
        [-> { place_ship_horizontal(ship) }, -> { place_ship_vertical(ship) }].sample.call
      end

      puts board.render(show: true)
      binding.pry
    end

    def place_ship_vertical(ship)
      valid_start_rows = letter_range_by_length("A", board.size - ship.length)

      valid_start_coords = valid_start_rows.each_with_object([]) do |row, valid_coords|
        1.upto(board.size) do |column|
          cell = board.cells["#{row}#{column}"]
          valid_coords << [row, column] if cell.empty?
        end
      end

      start_row, start_column = valid_start_coords.sample
      coords = letter_range_by_length(start_row, ship.length).map { |row| "#{row}#{start_column}" }

      board.place_ship(ship: ship, coordinates: coords)
    end

    def place_ship_horizontal(ship)
      valid_start_columns = range_by_length(1, board.size - ship.length)

      valid_start_coords = valid_start_columns.each_with_object([]) do |column, valid_coords|
        letter_range_by_length("A", board.size).each do |row|
          cell = board.cells["#{row}#{column}"]
          valid_coords << [row, column] if cell.empty?
        end
      end

      start_row, start_column = valid_start_coords.sample
      coords = range_by_length(start_column, ship.length).map { |column| "#{start_row}#{column}" }

      board.place_ship(ship: ship, coordinates: coords)
    end

    def range_by_length(start, length)
      start..((start + length) - 1)
    end

    def letter_range_by_length(start_chr, length)
      start_chr..(start_chr.ord + (length - 1)).chr
    end
end
