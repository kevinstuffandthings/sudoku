# frozen_string_literal: true

module Sudoku
  class Puzzle
    describe Solver do
      examples = Dir["spec/puzzle/examples/*.sudoku"] 

      it "has some examples to work with" do
        expect(examples.length).not_to be_zero
      end

      describe "#solve" do
        examples.each do |filename|
          context filename do
            let(:puzzle) { Sudoku::Puzzle.from_file(filename) }
            subject { Sudoku::Puzzle::Solver.new(puzzle) }

            it "gets solved" do
              subject.solve
              expect(puzzle).to be_solved
              puts "#{subject.utilization}"
            end
          end
        end
      end
    end
  end
end
