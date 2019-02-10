require_relative "test_helper"

class BoardPlacementTest < Minitest::Test
  def cells_from_coordinates(coordinates:)
    coordinates.map { |coord| Battleship::Cell.new(coordinate: coord) }
  end

  def test_invalid_too_few_coords
    ship = Battleship::Ship.new(name: "Cruiser", length: 3)
    coordinates = ["A1", "A2"]
    cells = cells_from_coordinates(coordinates: coordinates)

    refute Battleship::BoardPlacement.new(ship: ship, cells: cells).valid?
  end

  def test_invalid_too_many_coords
    ship = Battleship::Ship.new(name: "Cruiser", length: 3)
    coordinates = ["A1", "A2", "A3", "A4"]
    cells = cells_from_coordinates(coordinates: coordinates)

    refute Battleship::BoardPlacement.new(ship: ship, cells: cells).valid?
  end

  def test_invalid_if_not_consecutive
    ship = Battleship::Ship.new(name: "Cruiser", length: 3)

    coordinates = ["A1", "A2", "A4"]
    cells = cells_from_coordinates(coordinates: coordinates)
    refute Battleship::BoardPlacement.new(ship: ship, cells: cells).valid?

    coordinates = ["A1", "C1", "D1"]
    cells = cells_from_coordinates(coordinates: coordinates)
    refute Battleship::BoardPlacement.new(ship: ship, cells: cells).valid?

    coordinates = ["A4", "A2", "A1"]
    cells = cells_from_coordinates(coordinates: coordinates)
    refute Battleship::BoardPlacement.new(ship: ship, cells: cells).valid?

    coordinates = ["A1", "B2", "C3"]
    cells = cells_from_coordinates(coordinates: coordinates)
    refute Battleship::BoardPlacement.new(ship: ship, cells: cells).valid?
  end

  def test_valid
    ship = Battleship::Ship.new(name: "Cruiser", length: 3)

    coordinates = ["A1", "A2", "A3"]
    cells = cells_from_coordinates(coordinates: coordinates)
    assert Battleship::BoardPlacement.new(ship: ship, cells: cells).valid?

    coordinates = ["A1", "C1", "B1"]
    cells = cells_from_coordinates(coordinates: coordinates)
    assert Battleship::BoardPlacement.new(ship: ship, cells: cells).valid?

    coordinates = ["A4", "A2", "A3"]
    cells = cells_from_coordinates(coordinates: coordinates)
    assert Battleship::BoardPlacement.new(ship: ship, cells: cells).valid?
  end

  def test_invalid_if_overlapping
    ship = Battleship::Ship.new(name: "Cruiser", length: 3)

    coordinates = ["A1", "A2", "A3"]
    cells = cells_from_coordinates(coordinates: coordinates)

    assert Battleship::BoardPlacement.new(ship: ship, cells: cells).valid?

    cells[0].place_ship(new_ship: ship)
    refute Battleship::BoardPlacement.new(ship: ship, cells: cells).valid?
  end
end
