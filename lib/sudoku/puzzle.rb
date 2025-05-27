# frozen_string_literal: true

module Sudoku
  class Puzzle < Group
    attr_reader :cells

    def self.seed(textfile)
      puzzle = new
      cells = []
      text = File.read(textfile)

      text.lines.each_with_index do |row, y|
        (0..8).each do |x|
          value = row[x] if row[x].to_i != 0
          cells << Cell.new(puzzle, x + 1, y + 1, value)
        end
      end

      puzzle.instance_variable_set(:@cells, cells)
      puzzle
    end

    def row(y)
      Group.new(cells.select { |c| c.y == y })
    end

    def column(x)
      Group.new(cells.select { |c| c.x == x })
    end

    def region(rx, ry)
      Group.new(cells.select { |c| c.rx == rx && c.ry == ry })
    end

    def render
      (1..9).each do |y|
        puts (1..9).map { |x| cell(x, y).to_s }.join
      end
    end

    private

    def initialize
      @cells = []
    end
  end
end

require_relative "./puzzle/solver"