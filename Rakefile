# frozen_string_literal: true

namespace :sudoku do
  task :init do
    $LOAD_PATH << "./lib"
    require "sudoku"
  end

  desc "Solve the sudoku puzzle for the provided config file"
  task :solve, %i[config] => "sudoku:init" do |_, args|
    require "sudoku/puzzle/renderer"

    puzzle = Sudoku::Puzzle.seed(args[:config])
    solver = Sudoku::Puzzle::Solver.new(puzzle)
    renderer = Sudoku::Puzzle::Renderers::Simple.new(puzzle)

    renderer.render
    puts

    start_time = Time.now
    begin
      solver.solve
    rescue => ex
      renderer = Sudoku::Puzzle::Renderers::Debug.new(puzzle)
      puts "ERROR: #{ex}", ex.backtrace
    end
    duration = Time.now - start_time

    puts
    renderer.render
    puts "Solver spent #{duration}s"
    puts "PUZZLE UNSOLVED!".red unless puzzle.solved?
  end
end