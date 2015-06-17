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
RESPONSE_CODES = Hash.new(0)

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
  size = 5000
  b = time("new-#{size}") {
    r = HTTParty.get "http://local.host:3000/boards/#{TEAMNAMES.sample}/new?size=#{SIZES.sample}", logger: logger
    RESPONSE_CODES[r.code] += 1
    r
  }
  id = b['id']
  query_board id, size, logger
  id
end

def query_board(id, size, logger)
    5.times do
    {
      answer: "/boards/#{id}/person/#{rand(size)}",
      query: "/boards/#{id}/person?#{random_query}",
      multiquery: "/boards/#{id}/person?#{random_query}&#{random_query}",
    }.each do |type, path|
      time("#{type}") {
        r = HTTParty.get "http://local.host:3000/#{path}", logger: logger
        RESPONSE_CODES[r.code] += 1
      }
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

puts "\n---\n"
RESPONSE_CODES.each do |code, count|
  printf "%s: %5s", code, count
  puts
end
puts "--------------"
puts "Total: #{RESPONSE_CODES.values.reduce(:+)}"
puts
