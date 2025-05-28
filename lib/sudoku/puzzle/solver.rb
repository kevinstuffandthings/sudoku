# frozen_string_literal: true

module Sudoku
  class Puzzle
    class Solver
      attr_reader :puzzle
      delegate :cells, :block, :row, :column, to: :puzzle

      def initialize(puzzle)
        @puzzle = puzzle
      end

      def solve
        Solvers::NoteGenerator.new(puzzle).execute

        loop do
          progress = false
          solvers.each do |solver|
            progress = solver.execute || progress
          end
          break unless progress
        end
      end

      def solved?
        cells.all?(&:assigned?) && groups.all?(&:solved?)
      end

      private

      def solvers
        @_solvers ||= [
          Solvers::HiddenSingle,
          Solvers::HiddenPair
        ].map { |s| s.new(puzzle) }
      end

      def groups
        @_groups ||= vectors + blocks
      end

      def vectors
        @_vectors ||= (1..9).map { |y| row(y) } + (1..9).map { |x| column(x) }
      end

      def blocks
        @_blocks ||= (1..3).flat_map { |y| (1..3).map { |x| block(x, y) } }
      end
    end
  end
end

%w[
  note_generator
  hidden_single
  hidden_pair
].each { |f| require_relative "./solvers/#{f}" }