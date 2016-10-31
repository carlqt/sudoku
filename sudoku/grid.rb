module Sudoku
  class Grid
    DIGITS = (1..9).to_a
    ROWS = ("A".."I").to_a

    attr_reader :units, :peers, :squares
    attr_accessor :parsed_grid, :solutions_grid

    def initialize(input_grid)
      @grid = input_grid
      @squares = squares
      @parsed_grid = parse_grid
      @units = units
      @peers = peers
      @solutions_grid = init_solutions_grid
    end

    def self.digits_string
      DIGITS.join
    end

    def unit_list
      box_units = []
      col_units = {}
      row_units = {}

      col_units = DIGITS.map{ |col| cross(rows: ROWS, cols: [col]) }
      row_units = ROWS.map{ |row| cross(rows: [row], cols: DIGITS) }

      ROWS.each_slice(3) do |rs|
        DIGITS.each_slice(3) do |cs|
          box_units << cross(rows: rs, cols: cs)
        end
      end

      col_units + row_units + box_units
    end

    def units
      return @units if !@units.nil?

      units = {}

      @squares.each do |square|
        units[square] = unit_list.select{ |u| u.include?(square)}
      end
      units
    end

    def peers
      return @peers if !@peers.nil?
      peers = {}

      @squares.each do |square|
        peers[square] = (@units[square].inject(:+) - [square]).to_set
      end
      peers
    end

    def squares
      @squares ||= cross(rows: ROWS, cols: DIGITS)
    end

    def solved?
      @solutions_grid.all?{ |k,v| @solutions_grid[k].size == 1 }
    end

    def unsolved_squares
      @solutions_grid.select{ |k, v| v.size > 1 }.sort_by{ |k, v| v.size }
    end

    private

    def cross(rows:, cols:)
      rows.product(cols).map(&:join)
    end

    def parse_grid
      grid_values = {}
      @squares.each.with_index do |square, index|
        grid_values[square] = @grid[index]
      end
      grid_values
    end

    def init_solutions_grid
      solutions_grid = {}

      @squares.each do |square|
        solutions_grid[square] = '123456789'
      end

      solutions_grid
    end
  end
end
