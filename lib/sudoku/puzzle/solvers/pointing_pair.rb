# frozen_string_literal: true

module Sudoku
  class Puzzle
    module Solvers
      class PointingPair < Solver
        include GroupUtils

        # 2 or more squares contained in a single row/column within a block have an exclusive note,
        # so all other squares within that row/column (outside that block) should remove the note
        def execute
          utilization = 0

          blocks.each do |block|
            values = build_group_notemap(block).select { |_, v| v.length >= 2 }
            block_id = block_id_for(block.cells.first)

            values.each do |value, cells|
              vector = common_vector(cells) or next

              vector.cells.each do |cell|
                next if block_id_for(cell) == block_id

                old_notes = cell.notes
                new_notes = old_notes - [value]
                next if old_notes == new_notes

                cell.notes = new_notes
                $logger.info "#{name}: reducing notes within #{vector.type} from #{old_notes} for #{cell.description}"
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