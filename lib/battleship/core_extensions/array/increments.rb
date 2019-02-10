module Battleship
  module CoreExtensions
    module Array
      module Increments
        def increments?
          each_cons(2).all? { |a, b| a.to_i + 1 == b.to_i }
        end
      end
    end
  end
end

Array.include Battleship::CoreExtensions::Array::Increments
