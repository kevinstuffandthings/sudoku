# frozen_string_literal: true

module Sudoku
  class Puzzle
    module Solvers
      class Cell < Solver
        def solve(cell)
          candidates = (1..9).to_a - cell.row.values - cell.column.values - cell.block.values
          progress = if candidates.length == 1
            cell.assign(value: candidates.first)
          else
            cell.assign(candidates: candidates) unless candidates == cell.candidates
          end

          # puts cell.description
          !!progress
        end
      end
    end
  end
end