# frozen_string_literal: true

module Sudoku
  class Puzzle
    class Solver
      attr_reader :puzzle
      delegate :cells, :block, :row, :column, :groups, :vectors, :blocks, to: :puzzle

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

      protected

      def name
        @_name ||= self.class.name.demodulize
      end

      private

      def solvers
        @_solvers ||= [
          Solvers::HiddenSingle,
          Solvers::HiddenPair,
          Solvers::NakedPair,
          Solvers::PointingPair
        ].map { |s| s.new(puzzle) }
      end
    end
  end
end

%w[
  group_utils
  note_generator
  hidden_single
  hidden_pair
  naked_pair
  pointing_pair
].each { |f| require_relative "./solvers/#{f}" }