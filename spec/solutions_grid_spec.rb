require 'spec_helper'

describe Sudoku::SolutionsGrid do
  let(:input) { '003020600900305001001806400008102900700000008006708200002609500800203009005010300' }
  let(:parsed_grid) { Sudoku::Grid.new(input).parsed_grid }

  describe '.initialize' do
    subject(:grid){ Sudoku::SolutionsGrid.new(parsed_grid) }
    it 'initializes the squares (#grid) based on input. It applies constraint propagation immediately' do
      expect(grid.grid["A3"]).to eq 3.to_s
      expect(grid.grid["A5"]).to eq 2.to_s
    end
  end

  describe '#unsolved_squares' do
    let(:input) {'4.....8.5.3..........7......2.....6.....8.4......1.......6.3.7.5..2.....1.4......'}
    let(:parsed_grid) { Sudoku::Grid.new(input).parsed_grid }

    subject(:grid){ Sudoku::SolutionsGrid.new(parsed_grid).unsolved_squares }
    it 'returns all squares\' values that are greater than 1' do
      grid.each do |arr|
        expect(arr.last.size).to be > 1
      end
    end
  end

  describe '#solved?' do
    context 'when a square has 2 or more possible value' do
      let(:input) {'4.....8.5.3..........7......2.....6.....8.4......1.......6.3.7.5..2.....1.4......'}
      let(:parsed_grid) { Sudoku::Grid.new(input).parsed_grid }

      subject(:grid){ Sudoku::SolutionsGrid.new(parsed_grid).solved? }
      it 'returns false' do
        expect(grid).to eq false
      end
    end

    context 'when all squares has only 1 possible value' do
      subject(:grid){ Sudoku::SolutionsGrid.new(parsed_grid).solved? }
      it 'returns true' do
        expect(grid).to eq true
      end
    end
  end

  describe '#assign_and_propagate!' do
    let(:input) {'4.....8.5.3..........7......2.....6.....8.4......1.......6.3.7.5..2.....1.4......'}
    let(:sudoku_grid) { Sudoku::Grid.new(input) }
    let(:solutions_grid) { sudoku_grid.solutions_grid }

    before do
      sudoku_grid.parsed_grid.each do |square, value|
        if Sudoku::Grid.digits_string.include?(value) && solutions_grid.assign_and_propagate!(square, value)
          next
        end
      end
    end

    it 'assigns a value to a square and removes that value from its peers' do
      solutions_grid.assign_and_propagate!("A2", "1")
      expect(solutions_grid.grid["A2"]).to include("1")
      expect(solutions_grid.grid["C2"]).to_not include("1")
    end
  end

  describe '#search' do
    let(:input) {'.................................................................................'}
    let(:sudoku_grid) { Sudoku::Grid.new(input) }
    let(:solutions_grid) { sudoku_grid.solutions_grid }

    before do
      sudoku_grid.parsed_grid.each do |square, value|
        if Sudoku::Grid.digits_string.include?(value) && solutions_grid.assign_and_propagate!(square, value)
          next
        end
      end
    end

    it 'trys every possible values of the square until it reaches a solved state' do
      solutions_grid.search(solutions_grid.grid)

      expect(solutions_grid.solved?).to eq true
    end
  end
end
