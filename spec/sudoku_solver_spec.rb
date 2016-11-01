require 'support/input_helper'
require 'spec_helper'
include InputHelper

describe SudokuSolver do
  describe '#solve' do
    let(:hard1) {'4.....8.5.3..........7......2.....6.....8.4......1.......6.3.7.5..2.....1.4......'}

    it 'solves the sudoku puzzle' do
      sudoku = SudokuSolver.new(hard1)
      hard1_str = with_captured_stdout {sudoku.solve}
      expect{sudoku.solve}.to output(hard1_str).to_stdout
    end
  end
end
