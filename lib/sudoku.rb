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
