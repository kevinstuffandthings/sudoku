# frozen_string_literal: true

require "colorize"

module Sudoku
  class Cell
    attr_reader :x, :y, :seed

    def initialize(puzzle, x, y, seed = nil)
      @puzzle, @x, @y, @seed = puzzle, x, y, seed&.to_i
      @value = nil
    end

    def rx
      @_rx ||= ((x - 1) / 3) + 1
    end

    def ry
      @_ry ||= ((y - 1) / 3) + 1
    end

    def value
      @value || seed
    end

    def seeded?
      !seed.nil?
    end

    def row
      @_row ||= @puzzle.row(y)
    end

    def column
      @_column ||= @puzzle.column(x)
    end

    def region
      @_region ||= @puzzle.region(rx, ry)
    end

    def solved?
      !value.nil?
    end

    def solve!
      return if solved?

      solution = candidates
      puts "[#{x},#{y} (region #{rx},#{ry})] candidates: #{solution}"
      @value = solution.first if solution.length == 1
    end

    def to_s
      text = value&.to_s || "."
      text = text.blue if (rx + ry).odd?
      text = text.bold if seeded?
      text
    end

    private

    def candidates
      (1..9).to_a - row.values - column.values - region.values
    end
  end
end