module Sudoku
  class SolutionsGrid < BaseGrid
    def initialize(grid = nil)
      @grid = grid || init_solutions_grid
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
      # return false if !grid_values
      return grid_values if solved?(grid_values)

      key, value = unsolved_squares(grid_values).first

      value.chars.each do |val|
        some(search(assign_and_propagate(grid_values, key, val)))
      end
      # return some(search(assign(grid.copy(), key, value)) for d in values[s])
    end

    def some(seq)
      for e in seq do return e if e end
      return false
    end

    def assign_and_propagate(grid, key, value)
      assign(grid, key, value)
      eliminate(grid, key, value)
      grid
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

    def init_solutions_grid
      solutions_grid = {}

      squares.each do |square|
        solutions_grid[square] = '123456789'
      end

      solutions_grid
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
  end
end
