# frozen_string_literal: true

namespace :sudoku do
  task :init do
    $LOAD_PATH << "./lib"
    require "sudoku"
  end

  desc "Solve the sudoko puzzle for the provided config file"
  task :solve, %i[config] => "sudoku:init" do |_, args|
    puzzle = Sudoku::Puzzle.seed(args[:config])
    puzzle.solve!
    puzzle.render
  end
end