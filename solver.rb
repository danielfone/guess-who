require 'httparty'
require 'logger'
require 'benchmark'

class Board < Struct.new(:id, :population)

  def self.load(size)
    r = HTTParty.get "http://local.host:3000/boards/solver/new?size=#{size}"
    new r['id'], r['population']
  end

  def solve
    while population.size > 1
      ask_best!
    end
    guess! or fail "wrong :("
  end

  def guess!
    is_person? population.first['id']
  end

  def ask_best!
    k,v = best_query
    if person_has?(k,v)
      population.select! {|a| a[k] == v }
    else
      population.reject! {|a| a[k] == v }
    end
  end

  def person_has?(k,v)
    r = HTTParty.get "http://local.host:3000/boards/#{id}/person?#{k}=#{v}"
    case r.code
    when 200
      true
    when 204
      false
    else
      raise r
    end
  end

  def is_person?(person_id)
    r = HTTParty.get "http://local.host:3000/boards/#{id}/person/#{person_id}"
    case r.code
    when 200
      true
    when 204
      false
    else
      raise r
    end
  end

  def best_query
    _half = half
    population_distribution.sort_by { |q,count| (count - _half).abs }.first.first
  end

  def half
    population.size / 2
  end

  def attrs
    @attrs ||= population.first.keys - ["id"]
  end

  def population_distribution
    attrs.flat_map do |attr|
      population.group_by {|a| a[attr] }.map {|v,members| [[attr, v], members.size] }
    end
  end

end

#---

#r =
#pop = Population.new r['population']
require 'pry'
pry
