# frozen_string_literal: true

module Sudoku
  class Puzzle
    module Solvers
      class NakedPair < Solver
        include GroupUtils

        # two squares contain exactly 2 identical numbers within a group,
        # so those numbers can be removed from other groupmates' notes
        def execute
          utilization = 0

          groups.each do |group|
            find_pairs(group).each do |notes, pair|
              group.cells.each do |cell|
                old_notes = cell.notes
                new_notes = old_notes - notes
                next if cell.assigned? || pair.include?(cell) || old_notes == new_notes

                cell.notes = new_notes 
                $logger.info "#{name}: reducing notes within #{group.type} from #{old_notes} for #{cell.description}"
                utilization += 1
              end
            end
          end

          utilization
        end

        private

        def find_pairs(group)
          pairs = {}
          values = build_group_notemap(group)

          values.each do |v1, c1|
            values.each do |v2, c2|
              next unless v1 < v2
              pairs[[v1, v2]] = (c1 & c2).select { |c| c.notes == [v1, v2] }
            end
          end

          pairs.select { |n, p| p.length == 2 && p.all? { |c| c.notes.length == 2 } }
        end
      end
    end
  end
end