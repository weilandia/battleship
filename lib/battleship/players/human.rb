class Battleship::Player::Human < Battleship::Player
  private

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
