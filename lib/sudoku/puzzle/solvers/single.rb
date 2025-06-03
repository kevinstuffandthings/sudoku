# frozen_string_literal: true

module Sudoku
  class Puzzle
    module Solvers
      class Single < Solver
        # a cell only has a single note, so it is the definitive value for that cell
        def execute
          utilization = 0

          puzzle.cells.each do |cell|
            next unless cell.notes.length == 1

            value = cell.notes.first
            cell.value = value
            $logger.info "#{name}: assigning sole note #{value} to #{cell.description}"
            utilization += 1
          end

          utilization
        end
      end
    end
  end
end