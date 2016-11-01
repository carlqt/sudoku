module Sudoku
  class SolutionsGrid < BaseGrid
    def initialize(grid = nil)
      @grid = init_solutions_grid(grid)
    end

    def assign_and_propagate!(key, value)
      assign!(key, value)
      eliminate!(key, value)
      grid
    end

    def eliminate!(key, value)
      peers[key].each do |square|
        if grid[square].size > 1
          grid[square].gsub!(value, '')

          if grid[square].size == 1
            assign_and_propagate!(square, grid[square])
          end
        end
      end
    end

    def assign!(key, value)
      @grid[key] = value
    end

    def search(grid_values)
      if solved?(grid_values)
        @grid = grid_values
        return grid_values
      end

      key, value = unsolved_squares(grid_values).first

      return search(assign_and_propagate(grid_values.dup, key, value[0]))
    end

    def assign_and_propagate(grid, key, value)
      assign(grid, key, value)
      eliminate(grid, key, value)
    end

    def assign(grid, key, value)
      grid[key] = value
    end

    def eliminate(grid, key, value)
      peers[key].each do |square|
        if grid[square].size > 1
          grid[square].gsub!(value, '')

          if grid[square].size == 1
            assign_and_propagate(grid, square, grid[square])
          end
        end
      end

      grid
    end

    def init_solutions_grid(input_grid)
      assign_possible_values(input_grid)
    end

    def display
      max_size = squares.map{ |s| grid[s].size }.max + 1
      line = (["-" * max_size * 3] * 3).join("+")

      for r in ROWS do
        for c in DIGITS do
          values_str = grid["#{r}#{c}"]
          print values_str + (" " * (max_size - values_str.size))
          print "|" if c == 3 or c == 6
        end

        puts ""
        puts line if r == "C" or r == "F"
      end

    end

    def unsolved_squares(grid = nil)
      if grid.nil?
        @grid.select{ |k, v| v.size > 1 }.sort_by{ |k, v| v.size }
      else
        grid.select{ |k, v| v.size > 1 }.sort_by{ |k, v| v.size }
      end
    end

    def solved?(grid = nil)
      if grid.nil?
        @grid.all?{ |k,v| @grid[k].size == 1 }
      else
        grid.all?{ |k,v| grid[k].size == 1 }
      end
    end

    def peers
      @peers ||= super
    end

    def grid
      @grid
    end

    private

    def assign_possible_values(grid_input)
      @grid = {}
      squares.each do |k,v|
        @grid[k] = '123456789'
      end

      grid_input.each do |square, value|
        '123456789'.include?(value) && assign_and_propagate!(square, value)
      end
      @grid
    end
  end
end
