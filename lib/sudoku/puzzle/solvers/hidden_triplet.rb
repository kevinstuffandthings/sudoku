# frozen_string_literal: true

module Sudoku
  class Puzzle
    module Solvers
      class HiddenTriplet < Solver
        include GroupUtils

        # three cells within a group are the only ones containing a trio of numbers,
        # where each cell contains at least 2 of those 3 numbers. when this occurs,
        # those numbers can be removed from groupmates' notes
        def execute
          utilization = 0

          groups.each do |group|
            triplets = {}
            values = build_group_notemap(group).select { |_, c| c.length.between?(2, 3) }

            values.each do |v1, c1|
              values.each do |v2, c2|
                values.each do |v3, c3|
                  next unless v1 < v2 && v2 < v3
                  triplets[[v1, v2, v3]] = (c1 | c2 | c3).uniq
                end
              end
            end

            triplets.each do |notes, cells|
              next unless cells.length == 3

              cells.each do |cell|
                old_notes = cell.notes
                new_notes = (old_notes & notes).sort
                next if old_notes == notes

                cell.notes = new_notes
                $logger.info "#{name}: reducing notes within #{group.type} from #{old_notes} for #{cell.description}"
                utilization += 1
              end
            end
          end

          utilization
        end
      end
    end
  end
end