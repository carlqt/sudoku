module Sudoku
  class ConstraintPropagation
    def initialize(grid)
      @grid = grid
    end

    def execute!
      @grid.parsed_grid.each do |square, value|
        if Sudoku::Grid.digits_string.include?(value) && !assign!(@grid.solutions_grid, square, value)
          next
        end
      end

      @grid.solutions_grid
    end

    def assign!(grid, key, value)
      grid[key] = value
      eliminate!(grid, key, value)

      grid
    end

    def eliminate!(grid, key, value)
      @grid.peers[key].each do |square|
        if grid[square].size > 1
          grid[square].gsub!(value, '')

          if grid[square].size == 1
            assign!(grid, square, grid[square])
          end
        end
      end

    end
  end
end
