# frozen_string_literal: true

module Sudoku
  class Puzzle
    describe Solver do
      example_root = File.join(File.dirname(__FILE__), "examples")

      describe "#solve" do
        subject { Sudoku::Puzzle::Solver.new(puzzle) }

        shared_examples "a set of puzzles" do |root|
          examples = Dir[File.join(example_root, root, "*.sudoku")].sort
          utilization = Hash.new { |h, k| h[k] = 0 }
          after(:all) do
            puts "\n      Solver utilization:"
            utilization.to_a.sort_by { |_, k| k }.reverse.each do |name, quantity|
              puts "      - #{name}: #{quantity}"
            end
            puts
          end

          examples.each do |filename|
            context filename do
              let(:puzzle) { Sudoku::Puzzle.from_file(filename) }

              it "gets solved" do
                subject.solve
                expect(puzzle).to be_solved
                utilization.merge!(subject.utilization) { |_, o, n| o + n }
              end
            end
          end
        end

        context "apple news" do
          include_examples "a set of puzzles", "apple_news"
        end

        xcontext "world's hardest puzzles" do
          include_examples "a set of puzzles", "hardest"
        end
      end
    end
  end
end
