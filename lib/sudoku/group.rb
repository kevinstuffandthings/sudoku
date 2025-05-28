# frozen_string_literal: true

module Sudoku
  class Group
    attr_reader :cells

    def type
      return @_type if @_type

      x = cells.map(&:x).uniq
      y = cells.map(&:y).uniq

      return (@_type = :row) if y.length == 1
      return (@_type = :column) if x.length == 1
      @_type = :block
    end

    def cell(x, y)
      cells.find { |c| c.x == x && c.y == y }
    end
    
    def values
      cells.map { |c| c.value }.reject(&:nil?)
    end

    def solved?
      values.sort.uniq.count == 9
    end

    protected

    def initialize(cells)
      @cells = cells
    end
  end
end