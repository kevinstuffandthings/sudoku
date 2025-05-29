# frozen_string_literal: true

require "colorize"

module Sudoku
  class Cell
    AlreadyAssignedError = Class.new(StandardError)
    InvalidValueError = Class.new(StandardError)
    NotesDepletedError = Class.new(StandardError)
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
      raise AlreadyAssignedError.new("Attempting to reassign value #{value} to cell #{description}") if assigned?
      @value, @notes = value, []

      groups.each do |group|
        raise InvalidValueError.new("Newly assigned value #{value} for cell #{description} renders #{group.type} invalid") unless group.valid?

        group.cells.each do |mate|
          next if mate.assigned?

          mate.notes = mate.notes - [value]
        end
      end
    end

    def notes=(notes)
      raise AlreadyAssignedError.new("Attempting to add notes to assigned cell #{description}") if assigned?
      raise NotesDepletedError.new("Notes depleted for cell #{description}") if notes.empty?

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
  end
end