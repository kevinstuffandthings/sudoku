# frozen_string_literal: true

module Sudoku
  class Puzzle
    module Solvers
      class HiddenTriplet < Solver
        include GroupUtils

        # three cells within a group are the only ones containing a trio of numbers, so
        # those numbers can be removed from groupmates' notes
        def execute
          progress = false

          groups.each do |group|
            triplets = {}
            values = build_group_notemap(group).select { |_, v| v.length == 3 }

            values.each do |v1, c1|
              values.each do |v2, c2|
                values.each do |v3, c3|
                  next unless v1 < v2 && v2 < v3
                  triplets[[v1, v2, v3]] = c1 & c2 & c3
                end
              end
            end

            triplets.each do |notes, cells|
              next unless cells.length == 3

              cells.each do |cell|
                old_notes = cell.notes
                next if old_notes == notes

                cell.notes = notes
                puts "#{name}: reducing notes within #{group.type} from #{old_notes} for #{cell.description}"
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