module Sudoku
  class InputParser
    def self.parse!(input)
      raise "Input missing" if input.nil?

      parsed_file = input

      if File.file?(parsed_file)
        parsed_file = File.read(input).delete("\s\n")
      end
    end
  end
end
