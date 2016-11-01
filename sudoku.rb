require 'set'
require_relative './sudoku/base_grid'
require_relative './sudoku/solutions_grid'
require_relative './sudoku/grid'
require_relative './sudoku/constraint_propagation'

class SudokuSolver
  def initialize(grid)
    @sudoku_grid = Sudoku::Grid.new(grid)
  end

  def solve
    hard2  = '.................................................................................'
    solutions_grid = @sudoku_grid.solutions_grid
    # initialize solutions_grid
    @sudoku_grid.parsed_grid.each do |square, value|
      if Sudoku::Grid.digits_string.include?(value) && solutions_grid.assign_and_propagate!(square, value)
        next
      end
    end

    solutions_grid.search(hard2)
  end
end

grid1  = '003020600900305001001806400008102900700000008006708200002609500800203009005010300'
hard1 = '4.....8.5.3..........7......2.....6.....8.4......1.......6.3.7.5..2.....1.4......'

sgrid = Sudoku::Grid.new(grid1)
# s = Sudoku::ConstraintPropagation.new(sgrid)
# s.execute!
sol_grid = sgrid.solutions_grid
sgrid.parsed_grid.each do |square, value|
  if Sudoku::Grid.digits_string.include?(value) && sol_grid.assign_and_propagate!(square, value)
    next
  end
end
sol_grid.search(sol_grid.grid)
sol_grid.display
binding.pry
'he'
