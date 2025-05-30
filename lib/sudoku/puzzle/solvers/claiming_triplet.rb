# frozen_string_literal: true

module Sudoku
  class Puzzle
    module Solvers
      class ClaimingTriplet < Solver
        include GroupUtils

        # 3 cells within a block row contain a singular value not found in that row outside the block,
        # so that singular value can be removed from the remainder of the block
        def execute
          utilization = 0

          vectors.each do |vector|
            values = build_group_notemap(vector).select { |_, v| v.length == 3 }

            values.each do |value, cells|
              block = common_block(cells) or next

              block.cells.each do |cell|
                next if cell.assigned? || cells.include?(cell)

                old_notes = cell.notes
                new_notes = old_notes - [value]
                next if old_notes == new_notes

                cell.notes = new_notes
                $logger.info "#{name}: reducing notes within block from #{old_notes} for #{cell.description}"
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