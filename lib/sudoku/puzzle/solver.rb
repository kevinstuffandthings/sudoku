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
        loop do
          progress = cells.any? { |c| solve_cell(c) }
          break unless progress
        end
      end

      def solved?
        cells.all?(&:solved?) && groups.all?(&:solved?)
      end

      private

      def solve_cell(cell)
        return if cell.solved?

        solver = Solvers::Cell.new(puzzle)
        solver.solve(cell)
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

%w[cell].each { |f| require_relative "./solvers/#{f}" }