# frozen_string_literal: true

module Sudoku
  class Puzzle
    module Solvers
      class NakedPair < Solver
        include GroupUtils

        # two squares contain exactly 2 identical numbers within a group,
        # so those numbers can be removed from other groupmates' notes
        def execute
          progress = false

          groups.each do |group|
            pairs = {}
            values = build_group_notemap(group)

            values.each do |v1, c1|
              values.each do |v2, c2|
                next unless v1 < v2
                pairs[[v1, v2]] = c1 & c2
              end
            end

            pairs.each do |notes, pair|
              next unless notes.length == 2 && pair.length == 2 && pair.all? { |c| c.notes.length == 2 }

              group.cells.each do |cell|
                old_notes = cell.notes
                new_notes = old_notes - notes
                next if cell.assigned? || pair.include?(cell) || old_notes == new_notes

                cell.notes = new_notes 
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