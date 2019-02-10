require_relative "test_helper"

class ShipTest < Minitest::Test
  def setup
    @ship = Battleship::Ship.new(name: "Cruiser", length: 3)
  end

  def test_name
    assert_equal "Cruiser", @ship.name
  end

  def test_length
    assert_equal 3, @ship.length
  end

  def test_hit
    ship = Battleship::Ship.new(name: "Cruiser", length: 2)
    assert_equal 2, ship.health

    ship.hit
    assert_equal 1, ship.health

    ship.hit
    assert_equal 0, ship.health

    assert_nil ship.hit
    assert_equal 0, ship.health
  end

  def test_sunk?
    ship = Battleship::Ship.new(name: "Cruiser", length: 1)

    refute ship.sunk?

    ship.hit
    assert ship.sunk?
  end
end
