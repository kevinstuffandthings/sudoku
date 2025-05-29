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

      protected

      def rows
        @_rows ||= VALUES.map { |y| puzzle.row(y) }
      end
    end
  end
end

%w[simple debug].each { |f| require_relative "./renderers/#{f}" }