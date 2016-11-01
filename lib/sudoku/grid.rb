module Sudoku
  class Grid < BaseGrid
    attr_accessor :parsed_grid, :solutions_grid

    def initialize(input_grid)
      @grid = InputParser.parse!(input_grid)
      @parsed_grid = parse_grid
    end

    def solutions_grid
      @solutions_grid ||= SolutionsGrid.new(@parsed_grid)
    end

    def new_solutions_grid
      @solutions_grid = SolutionsGrid.new(@parsed_grid)
    end

    def self.digits_string
      DIGITS.join
    end

    private

    def parse_grid
      grid_values = {}
      squares.each.with_index do |square, index|
        grid_values[square] = @grid[index]
      end
      grid_values
    end
  end
end
