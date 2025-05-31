# frozen_string_literal: true

module Sudoku
  class Puzzle < Group
    VALUES = (1..9).to_a
    attr_reader :cells

    class << self
      def from_file(textfile)
        from_string(File.read(textfile))
      end

      def from_string(text)
        puzzle = new
        cells = []

        text.lines.each_with_index do |row, y|
          (0..8).each do |x|
            value = row[x] if row[x].to_i != 0
            cells << Cell.new(puzzle, x + 1, y + 1, value)
          end
        end

        puzzle.instance_variable_set(:@cells, cells)
        puzzle
      end
    end

    def row(y)
      Group.new(cells.select { |c| c.y == y })
    end

    def column(x)
      Group.new(cells.select { |c| c.x == x })
    end

    def block(bx, by)
      Group.new(cells.select { |c| c.bx == bx && c.by == by })
    end

    def groups
      @_groups ||= vectors + blocks
    end

    def vectors
      @_vectors ||= VALUES.map { |y| row(y) } + VALUES.map { |x| column(x) }
    end

    def blocks
      @_blocks ||= (1..3).flat_map { |y| (1..3).map { |x| block(x, y) } }
    end

    def solved?
      groups.all?(&:solved?)
    end

    def md5sum
      Digest::MD5.hexdigest(cells.map(&:md5sum).join("|"))
    end

    def clone
      text = VALUES.map { |x| row(x).cells.map { |c| c.value || "." }.join }.join("\n")
      self.class.from_string(text)
    end

    private

    def initialize
      @cells = []
    end
  end
end

require_relative "./puzzle/solver"