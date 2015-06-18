class GCSuite
  def warming(*)
    run_gc
  end

  def running(*)
    run_gc
  end

  def warmup_stats(*)
  end

  def add_report(*)
  end

  private

  def run_gc
    GC.enable
    GC.start
    GC.disable
  end
end

namespace :bench do
  task :json => :environment do
    require 'benchmark/ips'
    suite = GCSuite.new

    p = Population.new(5000).build
    ps = PopulationStrict.new(5000).build

    Benchmark.ips do |x|
      x.config(:suite => suite)

      x.report("build normal population")  { Population.new(5000).build }
      x.report("build strict population") { PopulationStrict.new(5000).build }

      x.compare!
    end

    Benchmark.ips do |x|
      x.config(:suite => suite)

      x.report("#to_json")  { Population.new(5000).build.to_json }
      x.report("Oj:object") { Oj.dump Population.new(5000).build, mode: :object }
      x.report("Oj:compat") { Oj.dump Population.new(5000).build, mode: :compat }

      x.report("[Strict] #to_json")  { PopulationStrict.new(5000).build.to_json }
      x.report("[Strict] Oj:strict") { Oj.dump PopulationStrict.new(5000).build, mode: :strict }
      x.report("[Strict] Oj:null")   { Oj.dump PopulationStrict.new(5000).build, mode: :null }
      x.report("[Strict] Oj:object") { Oj.dump PopulationStrict.new(5000).build, mode: :object }
      x.report("[Strict] Oj:compat") { Oj.dump PopulationStrict.new(5000).build, mode: :compat }

      x.compare!
    end

  end
end

=begin
Calculating -------------------------------------
   population normal     1.000  i/100ms
   population strict     1.000  i/100ms
-------------------------------------------------
   population normal     11.752  (± 8.5%) i/s -     59.000
   population strict     11.390  (± 8.8%) i/s -     57.000

Comparison:
   population normal:       11.8 i/s
   population strict:       11.4 i/s - 1.03x slower

Calculating -------------------------------------
            #to_json     1.000  i/100ms
           Oj:object     1.000  i/100ms
           Oj:compat     1.000  i/100ms
   [Strict] #to_json     1.000  i/100ms
  [Strict] Oj:strict     1.000  i/100ms
    [Strict] Oj:null     1.000  i/100ms
  [Strict] Oj:object     1.000  i/100ms
  [Strict] Oj:compat     1.000  i/100ms
-------------------------------------------------
            #to_json      3.008  (± 0.0%) i/s -     16.000  in   5.341788s
           Oj:object     11.435  (± 8.7%) i/s -     57.000
           Oj:compat      8.104  (±12.3%) i/s -     40.000
   [Strict] #to_json      3.456  (± 0.0%) i/s -     18.000  in   5.271059s
  [Strict] Oj:strict     11.250  (± 0.0%) i/s -     57.000
    [Strict] Oj:null     11.340  (± 0.0%) i/s -     57.000
  [Strict] Oj:object     11.249  (± 0.0%) i/s -     57.000
  [Strict] Oj:compat     11.343  (± 0.0%) i/s -     57.000

Comparison:
           Oj:object:       11.4 i/s
  [Strict] Oj:compat:       11.3 i/s - 1.01x slower
    [Strict] Oj:null:       11.3 i/s - 1.01x slower
  [Strict] Oj:strict:       11.2 i/s - 1.02x slower
  [Strict] Oj:object:       11.2 i/s - 1.02x slower
           Oj:compat:        8.1 i/s - 1.41x slower
   [Strict] #to_json:        3.5 i/s - 3.31x slower
            #to_json:        3.0 i/s - 3.80x slower

=end
