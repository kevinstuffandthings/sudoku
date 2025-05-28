# frozen_string_literal: true

module Sudoku
  class Puzzle
    module Solvers
      class NoteGenerator < Solver
        def execute
          cells.each do |cell|
            next if cell.assigned?

            notes = (1..9).to_a - cell.row.values - cell.column.values - cell.block.values
            cell.notes = notes
          end
        end
      end
    end
  end
end