# frozen_string_literal: true

module Sudoku
  class Puzzle
    describe Solver do
      Dir["spec/puzzle/puzzles/*.sudoku"].each do |filename|
        context filename do
          let(:puzzle) { Sudoku::Puzzle.from_file(filename) }
          subject { Sudoku::Puzzle::Solver.new(puzzle) }

          it "gets solved" do
            subject.solve
            expect(puzzle).to be_solved
          end
        end
      end
    end
  end
end
