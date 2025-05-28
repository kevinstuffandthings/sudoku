# frozen_string_literal: true

module Sudoku
  class Puzzle
    module Solvers
      class HiddenSingle < Solver
       # a cell has a note that is not present in any other one of its group members'
       # notes, so it should be taken as the value for that cell
        def execute
          progress = false

          groups.each do |group|
            values = (1..9).to_a.map { |v| [v, group.cells.select { |c| !c.assigned? && c.notes.include?(v) }] }.to_h

            values.each do |value, cells|
              next unless cells.length == 1

              cell = cells.first
              cell.value = value
              puts "HiddenSingle: exclusive assignment within #{group.type} for #{cell.description}"
              progress = true
            end
          end

          progress
        end
      end
    end
  end
end