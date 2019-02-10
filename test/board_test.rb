require_relative "test_helper"

class BoardTest < Minitest::Test
  def setup
    @board = Battleship::Board.new
  end

  def test_cells
    assert_equal 16, @board.cells.length
    assert_instance_of Battleship::Cell, @board.cells["A1"]
    assert_instance_of Battleship::Cell, @board.cells["D4"]
  end

  def test_valid_coordinate?
    assert @board.valid_coordinate?(coordinate: "A1")
    assert @board.valid_coordinate?(coordinate: "D1")
    refute @board.valid_coordinate?(coordinate: "F1")
    refute @board.valid_coordinate?(coordinate: "A5")
  end

  def test_valid_placement?
    ship = Battleship::Ship.new(name: "Cruiser", length: 3)
    coordinates = ["A1", "A2", "A3"]
    cells = coordinates.map { |coord| @board.cells[coord] }
    mock_placement = stub(valid?: true)

    Battleship::BoardPlacement.expects(:new).with(ship: ship, cells: cells).returns(mock_placement)

    assert @board.valid_placement?(ship: ship, coordinates: coordinates)
  end

  def test_invalid_placement_outise_of_board
    ship = Battleship::Ship.new(name: "Cruiser", length: 3)
    coordinates = ["F1", "F2", "F3"]

    refute @board.valid_placement?(ship: ship, coordinates: coordinates)
  end
end
