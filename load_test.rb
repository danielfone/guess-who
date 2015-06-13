require 'httparty'
require 'logger'
require 'benchmark'

TEAMNAMES = ['red', 'green', 'blue', 'pink', 'teal', 'purple']
SIZES = [3,3,3,100, 10, 1000, 5000]

ATTRIBUTES = {
  sex:         [:xx,       :xy],
  eyes:        [:blue,     :brown,      :cyclops],
  glasses:     [:none,     :sunglasses, :xray,     :prescription],
  hairstyle:   [:mullet,   :bald,       :updo,     :ringlets,      :dynamite],
  face:        [:eyeliner, :beard,      :rouge,    :sideburns,     :goatee,   :lipstick],
  haircolour:  [:brown,    :pink,       :orange,   :blonde,        :green,    :black, :grey, :white],
}

TIMES = Hash.new

def time(type)
  ret = nil
  TIMES[type] ||= []
  TIMES[type] << Benchmark.realtime { ret = yield }
  ret
end

def random_query
  attr = ATTRIBUTES.keys.sample
  field = ATTRIBUTES[attr].sample
  "#{attr}=#{field}"
end

def run_board(logger)
  size = SIZES.sample
  b = time("new-#{size}") { HTTParty.get "http://local.host:3000/boards/#{TEAMNAMES.sample}/new?size=#{SIZES.sample}", logger: logger }
  id = b['id']

  5.times do
    {
      answer: "/boards/#{id}/person/#{rand(size)}",
      query: "/boards/#{id}/person?#{random_query}",
      multiquery: "/boards/#{id}/person?#{random_query}&#{random_query}",
    }.each do |type, path|
      time("#{type}") { HTTParty.get "http://local.host:3000/#{path}", logger: logger }
    end
  end
end

CONCURRENCY = Integer(ENV['CONCURRENCY'] || 1)
ITERATIONS  = Integer(ENV['ITERATIONS'] || 1)

threads = CONCURRENCY.times.map do
  Thread.new do
    ITERATIONS.times do
      run_board Logger.new("/dev/null")
    end
  end
end

threads.each &:join


TIMES.each do |type, results|
  average = results.reduce(:+) / results.size.to_f
  printf "%-15s", type
  puts "#{average.round(3)} s (#{results.size})"
end

