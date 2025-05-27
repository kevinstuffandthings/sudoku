# frozen_string_literal: true

module Sudoku
  class Puzzle
    class Solver
      attr_reader :puzzle
      delegate :cells, :region, :row, :column, to: :puzzle

      def initialize(puzzle)
        @puzzle = puzzle
      end

      def solve
        loop do
          solves = cells.map(&:solve!).reject(&:nil?).count
          break if solves.zero?
        end
      end

      def solved?
        cells.all?(&:solved?) && (regions + vectors).all?(&:solved?)
      end

      private

      def regions
        @_regions ||= (1..3).flat_map { |y|
          (1..3).map { |x| region(x, y) }
        }
      end

      def vectors
        @_vectors ||= (1..9).map { |y| row(y) } + (1..9).map { |x| column(x) }
      end
    end
  end
end