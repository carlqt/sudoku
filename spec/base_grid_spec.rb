require 'spec_helper'

describe Sudoku::BaseGrid do
  describe '#peers' do
    subject(:grid) { Sudoku::BaseGrid.new.peers }
    it 'is a collection of unique squares. They are squares on the same row, column and box/unit' do
      expect(grid["A1"]).to eq ["B1", "C1", "D1", "E1", "F1", "G1", "H1", "I1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9", "B2", "B3", "C2", "C3"].to_set
    end
  end

  describe '#squares' do
    subject(:grid) { Sudoku::BaseGrid.new.squares }
    it 'is a representation of box to put the values' do
      expect(grid).to include("A1", "I9", "C7")
    end
  end

  describe '#units' do
    subject(:grid) { Sudoku::BaseGrid.new.units }
    it 'is the collection of 9 squares' do
      expect(grid["A2"]).to include(["A2", "B2", "C2", "D2", "E2", "F2", "G2", "H2", "I2"])
      expect(grid["A2"]).to include(["A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9"])
      expect(grid["A2"]).to include(["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"])
    end
  end
end
