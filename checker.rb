#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/checker/bracket_checker'

expression = ARGV.pop
begin
  check_result = BracketChecker.new(expression).check
  puts check_result.inspect
rescue ArgumentError => e
  puts(e)
  exit(2)
end
