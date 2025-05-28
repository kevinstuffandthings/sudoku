# frozen_string_literal: true

module Sudoku
  class Puzzle
    module Solvers
      class HiddenSingle < Solver
       # a cell has a note that is not present in any other one of its group members'
       # notes, so it should be taken as the value for that cell
        def execute
          progress = false

          cells.each do |cell|
            next if cell.assigned?

            cell.notes.each do |value|
              break if cell.assigned?

              cell.groups.each do |group|
                present = false

                group.cells.each do |mate|
                  next if cell == mate
                  present = true if mate.notes.include?(value)
                end

                if !present
                  cell.value = value
                  puts "HiddenSingle: exclusive assignment within #{group.type} for #{cell.description}"
                  progress = true
                  break
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