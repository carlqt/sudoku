module Sudoku
  class ConstraintPropagation
    def initialize(grid)
      @grid = grid
    end

    def execute!
      @grid.parsed_grid.each do |square, value|
        if Sudoku::Grid.digits_string.include?(value) && !assign!(square, value)
          next
        end
      end

      @grid.solutions_grid
    end

    def assign!(key, value)
      @grid.solutions_grid[key] = value
      eliminate!(key, value)

      @grid.solutions_grid
    end

    def eliminate!(key, value)
      @grid.peers[key].each do |square|
        if @grid.solutions_grid[square].size > 1
          @grid.solutions_grid[square].gsub!(value, '')

          if @grid.solutions_grid[square].size == 1
            assign!(square, @grid.solutions_grid[square])
          end
        end
      end

    end
  end
end
