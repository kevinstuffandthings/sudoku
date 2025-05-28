# frozen_string_literal: true

require "active_support/all"

$logger = Logger.new($stdout)

%w[
  cell
  group
  puzzle
].each { |f| require "sudoku/#{f}" }