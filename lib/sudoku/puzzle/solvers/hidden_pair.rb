# frozen_string_literal: true

module Sudoku
  class Puzzle
    module Solvers
      class HiddenPair < Solver
        include GroupUtils

        # two cells within a group are the only ones containing a pair of numbers, so
        # other numbers can be removed from those cells' notes
        def execute
          progress = false

          groups.each do |group|
            pairs = {}
            values = build_group_notemap(group).select { |_, v| v.length == 2 }

            values.each do |v1, c1|
              values.each do |v2, c2|
                next unless v1 < v2
                pairs[[v1, v2]] = c1 & c2
              end
            end

            pairs.each do |notes, cells|
              next unless cells.length == 2

              cells.each do |cell|
                old_notes = cell.notes
                next if old_notes == notes

                cell.notes = notes
                $logger.info "#{name}: reducing notes within #{group.type} from #{old_notes} for #{cell.description}"
                progress = true
              end
            end
          end

          progress
        end
      end
    end
  end
end