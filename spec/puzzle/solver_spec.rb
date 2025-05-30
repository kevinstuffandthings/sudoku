# frozen_string_literal: true

module Sudoku
  class Puzzle
    describe Solver do
      examples = Dir["spec/puzzle/examples/*.sudoku"] 

      it "has some examples to work with" do
        expect(examples.length).not_to be_zero
      end

      describe "#solve" do
        subject { Sudoku::Puzzle::Solver.new(puzzle) }
        before(:each) { subject.solve }

        examples.each do |filename|
          context filename do
            let(:puzzle) { Sudoku::Puzzle.from_file(filename) }

            it "gets solved" do
              expect(puzzle).to be_solved
            end
          end
        end

        xcontext "world's hardest puzzle" do
          let(:text) do
            <<~EOF
              ..53.....
              8......2.
              .7..1.5..
              4....53..
              .1..7...6
              ..32...8.
              .6.5....9
              ..4....3.
              .....97..
            EOF
          end
          let(:puzzle) { Sudoku::Puzzle.from_string(text) }

          it "gets solved" do
            expect(puzzle).to be_solved
          end
        end
      end
    end
  end
end
