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
