module Sudoku
  class BaseGrid
    DIGITS = (1..9).to_a
    ROWS = ("A".."I").to_a

    def squares
      @squares ||= ("A1".."I9").to_a.select{ |n| n.match /.[1-9]/ }
    end

    def units
      return @units if !@units.nil?

      units = {}

      squares.each do |square|
        units[square] = unit_list.select{ |u| u.include?(square)}
      end
      units
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

    def peers
      return @peers if !@peers.nil?
      peers = {}

      squares.each do |square|
        peers[square] = (units[square].inject(:+) - [square]).to_set
      end
      peers
    end

    def cross(rows:, cols:)
      rows.product(cols).map(&:join)
    end
  end
end
