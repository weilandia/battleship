class Battleship::Player::Human < Battleship::Player
  def take_turn
    puts "=============OPPONENT BOARD============="
    puts opponent.board.render
    puts "==============YOUR BOARD=============="
    puts board.render(show: true)

    puts "=============YOUR TURN=============\n\n"
    puts "Enter the coordinate for your shot:"
    fire_shot
  end

  private

    def fire_shot
      coordinate = gets.chomp
      cell = opponent.board.cells[coordinate]
      return invalid_shot unless cell
      return already_shot(coordinate: coordinate) if cell.fired_upon?

      attack(cell: cell)
      process_valid_shot(cell: cell)
    end

    def already_shot(coordinate:)
      puts "You've already shot at #{coordinate}. Please choose another:"
      fire_shot
    end

    def invalid_shot
      puts "Please enter a valid coordinate:"
      fire_shot
    end

    def process_valid_shot(cell:)
      puts "Your #{cell.render_attack_result}"
    end

    def place_ships
      puts placement_instructions

      ships.each do |ship|
        place_ship(ship: ship)
      end
    end

    def placement_instructions
      "\nYou need to lay out your two ships.\n\n"
    end

    def place_ship(ship:)
      puts board.render(show: true)
      puts "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
      coords = gets.chomp.split(" ")

      return if board.place_ship(ship: ship, coordinates: coords)

      puts "Invalid coordinates."
      place_ship(ship: ship)
    end
end
