module Sudoku
  describe Puzzle do
    Dir["spec/puzzles/*.sudoku"].each do |filename|
      context filename do
        let(:puzzle) { Sudoku::Puzzle.seed(filename) }
        let(:solver) { Sudoku::Puzzle::Solver.new(puzzle) }

        it "gets solved" do
          solver.solve
          expect(puzzle).to be_solved
        end
      end
    end
  end
end
