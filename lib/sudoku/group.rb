# frozen_string_literal: true

module Sudoku
  class Group
    attr_reader :cells

    def cell(x, y)
      cells.find { |c| c.x == x && c.y == y }
    end
    
    def values
      cells.map { |c| c.value }.reject(&:nil?)
    end

    protected

    def initialize(cells)
      @cells = cells
    end
  end
end