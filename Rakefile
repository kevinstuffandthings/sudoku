# frozen_string_literal: true

namespace :sudoku do
  task :init do
    $LOAD_PATH << "./lib"
    require "sudoku"
  end

  desc "Solve the sudoku puzzle for the provided config file"
  task :solve, %i[config] => "sudoku:init" do |_, args|
    require "sudoku/puzzle/renderer"

    puzzle = if (filename = args[:config]).present?
      Sudoku::Puzzle.from_file(args[:config])
    else
      Sudoku::Puzzle.from_string(STDIN.read)
    end
    solver = Sudoku::Puzzle::Solver.new(puzzle)
    renderer = Sudoku::Puzzle::Renderers::Simple.new(puzzle)

    if $logger.level <= 1
      renderer.render
      puts
    end

    start_time = Time.now
    begin
      solver.solve
    rescue => ex
      renderer = Sudoku::Puzzle::Renderers::Debug.new(puzzle)
      puts "ERROR: #{ex}", ex.backtrace
    end
    duration = Time.now - start_time

    puts if $logger.level <= 1
    renderer.render
    $logger.info "Solver spent #{duration}s (#{solver.utilization.map { |k, v| "#{k}: #{v}" }.join(", ")})"
    $logger.error "PUZZLE UNSOLVED!" unless puzzle.solved?
  end
end
