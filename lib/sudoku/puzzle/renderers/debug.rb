# frozen_string_literal: true

module Sudoku
  class Puzzle
    module Renderers
      class Debug < Renderer
        HEADER = "#{TL}#{X * 15}#{TC}#{X * 15}#{TC}#{X * 15}#{TR}"
        SPACER = "#{Y}#{" " * 15}#{Y}#{" " * 15}#{Y}#{" " * 15}#{Y}"
        MIDDLE = "#{LC}#{X * 15}#{C}#{X * 15}#{C}#{X * 15}#{RC}"
        FOOTER = "#{BL}#{X * 15}#{BC}#{X * 15}#{BC}#{X * 15}#{BR}"

        def to_s
          text = rows.map { |r| row_to_s(r) }
            .in_groups_of(3)
            .map { |r| r.join("\n#{SPACER}\n") }
            .in_groups_of(3)
            .join("\n#{MIDDLE}\n")
          # binding.pry

          [
            HEADER,
            *text,
            FOOTER
          ]
        end

        private

        def row_to_s(row)
          cells = row.cells.map { |c| cell_to_s(c) }
            .transpose
            .map { |r| r.in_groups_of(3).map { |c| c.join("  ") } }
            .map { |r| "#{Y} " + r.join(" #{Y} ") + " #{Y}" }
          #[SPACER, *cells, SPACER].join("\n")
          cells.join("\n")
        end

        def cell_to_s(cell)
          if (text = cell.value&.to_s)
            ["   ", " #{text} ", "   "].map { |x| cell.seeded? ? x.on_gray : x.on_green }
          else
            VALUES.in_groups_of(3).map do |group|
              group.map { |n| cell.notes.include?(n) ? n.to_s : " " }.map(&:on_yellow).join
            end
          end
        end
      end
    end
  end
end