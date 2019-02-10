require_relative "test_helper"

class CellTest < Minitest::Test
  def setup
    @cell = Battleship::Cell.new(coordinate: "A1")
  end

  def test_coordinate
    assert_equal "A1", @cell.coordinate
  end

  def test_place_ship
    assert_nil @cell.ship

    mock_ship = "ship"

    assert @cell.place_ship(new_ship: mock_ship)
    assert_equal mock_ship, @cell.ship

    refute @cell.place_ship(new_ship: mock_ship)
  end

  def test_empty?
    assert @cell.empty?

    mock_ship = "ship"

    assert @cell.place_ship(new_ship: mock_ship)
    refute @cell.empty?
  end

  def test_fired_upon?
    refute @cell.fired_upon?

    @cell.fired_upon = true
    assert @cell.fired_upon?
  end

  def test_fire_upon_without_ship
    @cell.fire_upon

    assert @cell.fired_upon?
  end

  def test_fire_upon_with_ship
    ship = Battleship::Ship.new(name: "Cruiser", length: 3)
    @cell.place_ship(new_ship: ship)

    @cell.fire_upon
    assert @cell.fired_upon?
    assert_equal 2, ship.health
  end

  def test_render_not_fired_empty
    assert_equal ".", @cell.render
  end

  def test_render_not_fired_with_ship
    ship = Battleship::Ship.new(name: "Cruiser", length: 3)
    @cell.place_ship(new_ship: ship)

    assert_equal ".", @cell.render
  end

  def test_render_not_fired_with_ship_show_ship
    ship = Battleship::Ship.new(name: "Cruiser", length: 3)
    @cell.place_ship(new_ship: ship)

    assert_equal "S", @cell.render(show_ship: true)
  end

  def test_render_fired_empty
    @cell.fire_upon
    assert_equal "M", @cell.render
  end

  def test_render_fired_hit
    ship = Battleship::Ship.new(name: "Cruiser", length: 3)
    @cell.place_ship(new_ship: ship)
    @cell.fire_upon

    assert_equal "H", @cell.render
  end

  def test_render_fired_sunk
    ship = Battleship::Ship.new(name: "Cruiser", length: 1)
    @cell.place_ship(new_ship: ship)
    @cell.fire_upon

    assert_equal "X", @cell.render
  end
end
