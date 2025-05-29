# frozen_string_literal: true

require "active_support/all"

$logger = Logger.new(STDOUT)
$logger.level = :info
$logger.formatter = proc do |severity, datetime, progname, msg|
   "#{severity}: #{msg}\n"
end


%w[
  cell
  group
  puzzle
].each { |f| require "sudoku/#{f}" }
