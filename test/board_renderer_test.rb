require_relative "test_helper"

class BoardRendererTest < Minitest::Test
  def setup
    @board = Battleship::Board.new
  end

  def test_empty_boad
    render = Battleship::BoardRenderer.call(rows: @board.rows)
    expected_render = "  1 2 3 4\nA . . . .\n\nB . . . .\n\nC . . . .\n\nD . . . .\n"
    assert_equal expected_render, render
    assert_equal expected_render, render
  end
end
