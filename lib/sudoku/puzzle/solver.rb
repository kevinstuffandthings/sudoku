# frozen_string_literal: true

module Sudoku
  class Puzzle
    class Solver
      attr_reader :puzzle, :utilization
      delegate :cells, :block, :row, :column, :groups, :vectors, :blocks, to: :puzzle

      def initialize(puzzle)
        @puzzle = puzzle
        @utilization = Hash.new { |h, k| h[k] = 0 }
      end

      def solve
        Solvers::NoteGenerator.new(puzzle).execute

        loop do
          sum = puzzle.md5sum
          solvers.each do |solver|
            if (num_changes = solver.execute) > 0
              utilization[solver.name.to_sym] += num_changes
            end
          end
          break if puzzle.md5sum == sum
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
          Solvers::PointingPair,
          Solvers::HiddenTriplet,
          Solvers::ClaimingTriplet
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
  hidden_triplet
  claiming_triplet
].each { |f| require_relative "./solvers/#{f}" }
