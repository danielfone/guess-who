require_relative './solver'
require 'benchmark'

TIMES = Hash.new

def time(type)
  ret = nil
  TIMES[type] ||= []
  TIMES[type] << Benchmark.realtime { ret = yield }
  ret
end

CONCURRENCY = Integer(ENV['CONCURRENCY'] || 1)
ITERATIONS  = Integer(ENV['ITERATIONS'] || 1)

threads = CONCURRENCY.times.map do |i|
  Thread.new do
    Board.create("team-#{i}", 1).delete! # Remove left over board
    ITERATIONS.times do
      time('solve') { Solver.load("team-#{i}", 5000).solve }
    end
  end
end

threads.each &:join


TIMES.each do |type, results|
  average = results.reduce(:+) / results.size.to_f
  printf "%-15s", type
  puts "#{average.round(3)} s (#{results.size})"
end
