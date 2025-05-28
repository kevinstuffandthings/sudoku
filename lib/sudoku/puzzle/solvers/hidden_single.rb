# frozen_string_literal: true

module Sudoku
  class Puzzle
    module Solvers
      class HiddenSingle < Solver
        include GroupUtils

        # a cell has a note that is not present in any other one of its group members'
        # notes, so it should be taken as the value for that cell
        def execute
          progress = false

          groups.each do |group|
            values = build_group_notemap(group).select { |_, v| v.length == 1 }

            values.each do |value, cells|
              cell = cells.first
              next if cell.assigned?

              cell.value = value
              $logger.info "#{name}: exclusive assignment within #{group.type} for #{cell.description}"
              progress = true
            end
          end

          progress
        end
      end
    end
  end
end