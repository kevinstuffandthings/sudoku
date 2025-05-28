# frozen_string_literal: true

module Sudoku
  class Puzzle
    class Renderer
      X = '─'
      Y = '│'
      LC = '├'
      RC = '┤'
      C = '┼'
      TL = '┌'
      TC = '┬'
      TR = '┐'
      BL = '└'
      BC = '┴'
      BR = '┘'

      attr_reader :puzzle

      def initialize(puzzle)
        @puzzle = puzzle
      end

      def render
        puts to_s
      end

      def to_s
        text = rows.map { |r| row_to_s(r) }
          .in_groups_of(3)
          .zip(2.times.map { "#{LC}#{X * 3}#{C}#{X * 3}#{C}#{X * 3}#{RC}" })
          .flatten(1)
          .compact

        [
          "#{TL}#{X * 3}#{TC}#{X * 3}#{TC}#{X * 3}#{TR}",
          *text,
          "#{BL}#{X * 3}#{BC}#{X * 3}#{BC}#{X * 3}#{BR}"
        ]
      end

      private

      def rows
        @_rows ||= VALUES.map { |y| puzzle.row(y) }
      end

      def row_to_s(row)
        values = row.cells.map { |c| cell_to_s(c) }
        Y + values.in_groups_of(3).map { |g| g.join }.join(Y) + Y
      end

      def cell_to_s(cell)
        text = cell.value&.to_s || " "
        text = text.on_gray if cell.seeded?
        text
      end
    end
  end
end