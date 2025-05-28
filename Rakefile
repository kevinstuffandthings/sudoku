# frozen_string_literal: true

namespace :sudoku do
  task :init do
    $LOAD_PATH << "./lib"
    require "sudoku"
  end

  desc "Solve the sudoko puzzle for the provided config file"
  task :solve, %i[config] => "sudoku:init" do |_, args|
    puzzle = Sudoku::Puzzle.seed(args[:config])
    solver = Sudoku::Puzzle::Solver.new(puzzle)

    start_time = Time.now
    solver.solve
    duration = Time.now - start_time

    puts
    puzzle.render
    puts "Solver spent #{duration}s"
    puts "PUZZLE UNSOLVED!".red unless puzzle.solved?
  end
end