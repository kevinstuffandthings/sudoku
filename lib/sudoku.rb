# frozen_string_literal: true

require "active_support/all"

%w[
  cell
  group
  puzzle
].each { |f| require "sudoku/#{f}" }