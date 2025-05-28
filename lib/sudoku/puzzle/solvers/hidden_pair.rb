# frozen_string_literal: true

module Sudoku
  class Puzzle
    module Solvers
      class HiddenPair < Solver
        # a two cells within a group are the only ones containing a pair of numbers, so
        # those numbers can be removed from groupmates' notes
        def execute
          progress = false

          cells.each do |cell|
            next if cell.assigned?

            cell.notes.each do |note|
              break if cell.assigned?

              cell.groups.each do |group|
                present = false

                group.cells.each do |mate|
                  next if cell == mate

                  if mate.notes.include?(note)
                  end
                end
              end
            end
          end

          progress
        end
      end
    end
  end
end