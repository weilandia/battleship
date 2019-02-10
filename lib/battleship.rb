require "pry"

require "battleship/version"

require "battleship/core_extensions/array/increments"

require "battleship/ship"
require "battleship/ships/cruiser"
require "battleship/ships/submarine"

require "battleship/cell"
require "battleship/board"
require "battleship/board_placement"
require "battleship/board_renderer"

require "battleship/player"
require "battleship/players/computer"
require "battleship/players/human"

require "battleship/game"

module Battleship
  class Error < StandardError; end
end
