# frozen_string_literal: true

module Sudoku
  class Puzzle
    module Solvers
      module GroupUtils
        Vector = Struct.new(:axis, :type)
        VECTORS = [Vector.new(:x, :column), Vector.new(:y, :row)]

        private

        def build_group_notemap(group)
          values = VALUES
            .map { |v| [v, group.cells.select { |c| !c.assigned? && c.notes.include?(v) }] }
            .to_h
            .select { |_, v| v.present? }
        end

        def common_vector(cells)
          VECTORS.each do |vector|
            indexes = cells.map { |c| c.public_send(vector.axis) }.sort.uniq
            return public_send(vector.type, indexes.first) if indexes.length == 1
          end

          nil
        end

        def common_block(cells)
          bx, by = cells.map(&:bx), cells.map(&:by)
          return unless bx.length == 1 && by.length == 1

          block(bx.first, by.first)
        end

        def block_id_for(cell)
          [:bx, :by].map { |a| cell.public_send(a) }
        end
      end
    end
  end
end