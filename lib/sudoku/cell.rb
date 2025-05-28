# frozen_string_literal: true

require "colorize"

module Sudoku
  class Cell
    AlreadyAssignedError = Class.new(StandardError)
    attr_reader :x, :y, :seed, :notes

    def initialize(puzzle, x, y, seed = nil)
      @puzzle, @x, @y, @seed = puzzle, x, y, seed&.to_i
      @notes, @value = [], nil
    end

    def bx
      @_bx ||= ((x - 1) / 3) + 1
    end

    def by
      @_by ||= ((y - 1) / 3) + 1
    end

    def value
      @value || seed
    end

    def value=(value)
      raise AlreadyAssignedError if assigned?
      @value, @notes = value, []

      groups.each do |group|
        group.cells.each do |mate|
          next if mate.assigned?
          mate.notes.delete(value)
        end
      end
    end

    def notes=(notes)
      raise AlreadyAssignedError if assigned?
      @notes = notes
    end

    def seeded?
      !seed.nil?
    end

    def groups
      @_groups ||= [row, column, block]
    end

    def row
      @_row ||= @puzzle.row(y)
    end

    def column
      @_column ||= @puzzle.column(x)
    end

    def block
      @_block ||= @puzzle.block(bx, by)
    end

    def assigned?
      !value.nil?
    end

    def description
      "[#{x},#{y} (B#{bx},#{by})] -> #{value || notes}"
    end

    def to_s
      text = value&.to_s || "."
      text = text.blue if (bx + by).odd?
      text = text.bold if seeded?
      text
    end
  end
end