require 'optparse'
require 'set'
require 'pry'
require_relative './sudoku/base_grid'
require_relative './sudoku/input_parser'
require_relative './sudoku/solutions_grid'
require_relative './sudoku/grid'

class SudokuSolver
  def initialize(grid)
    @sudoku_grid = Sudoku::Grid.new(grid)
  end

  def solve
    solutions_grid = @sudoku_grid.solutions_grid
    solutions_grid.search(solutions_grid.grid)
    solutions_grid.display
  end
end

grid1  = '003020600900305001001806400008102900700000008006708200002609500800203009005010300'
hard1 = '4.....8.5.3..........7......2.....6.....8.4......1.......6.3.7.5..2.....1.4......'
hard2  = '.................................................................................'
ez = '237168945648597321189342576726453819394281657815779234973624768561976482472835196'

g = Sudoku::Grid.new hard1
g.solutions_grid
ARGV << '-h' if ARGV.empty?

options = {}
OptionParser.new do |opts|
  opts.banner = "Sudoku solver from Peter Norvig's solution. Ported to ruby"
  opts.banner += "GuavaPass"
  opts.separator ""

  opts.on("-fFILE", "--file FILE", "The filename of the input. e.g. input.sudoku ") do |f|
    options[:file] = f
  end
end.parse!


if !options[:file].nil?
  sudoku = SudokuSolver.new(options[:file])
  sudoku.solve
end
