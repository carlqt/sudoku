require 'optparse'
require 'set'
require 'pry'
require_relative './sudoku/base_grid'
require_relative './sudoku/input_parser'
require_relative './sudoku/solutions_grid'
require_relative './sudoku/grid'
require_relative './sudoku/sudoku_solver'

ARGV << '-h' if ARGV.empty?

options = {}
OptionParser.new do |opts|
  opts.banner = "Sudoku solver from Peter Norvig's solution. Ported to ruby"
  opts.banner += "GuavaPass"
  opts.separator ""

  opts.on("-fFILE", "--file FILE", "The filename of the input. e.g. input.sudoku ") do |f|
    options[:file] = f
  end

  opts.on("-cINPUT", "--cin INPUT", "Input text") do |c|
    options[:c_in] = c
  end
end.parse!


if options[:file] || options[:c_in]
  sudoku = SudokuSolver.new(options[:file] || options[:c_in])
  sudoku.solve
end
