require 'set'
require 'pry'
require_relative './sudoku/grid'
require_relative './sudoku/constraint_propagation'

class SudokuSolver
  def initialize(grid)
    @sudoku_grid = Sudoku::Grid.new(grid)
  end

  def solve
    contstraint = Sudoku::ConstraintPropagation.new(@sudoku_grid)
    constraint.execute!

    if @sudoku_grid.solved?
      puts @sudoku_grid.solutions_grid
    else
      constraint_copy = constraint.dup
    end
  end
end

grid1  = '003020600900305001001806400008102900700000008006708200002609500800203009005010300'
hard1 = '4.....8.5.3..........7......2.....6.....8.4......1.......6.3.7.5..2.....1.4......'

sgrid = Sudoku::Grid.new(hard1)
s = Sudoku::ConstraintPropagation.new(sgrid)
s.execute!
binding.pry
'he'
