require 'httparty'

#
# This is a possibly helpful class for interacting with the API
#
# board = Board.create 100
# board.population                    => [{"hair" => "brown"...}]
# board.person_has? 'hair', 'brown'   => true
# board.is_person? 4                  => false
#

class Board < Struct.new(:id, :population)
  HOST = "local.host:3000"

  def self.create(size)
    r = HTTParty.get "http://#{HOST}/boards/solver/new?size=#{size}"
    new r['id'], r['population']
  end

  def person_has?(k,v)
    r = HTTParty.get "http://#{HOST}/boards/#{id}/person?#{k}=#{v}"
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
    r = HTTParty.get "http://#{HOST}/boards/#{id}/person/#{person_id}"
    case r.code
    when 200
      true
    when 204
      false
    else
      raise r
    end
  end

  def delete!
    HTTParty.delete("http://#{HOST}/boards/#{id}")
  end

end

#
# This is a reference implementation for solving the board
# and may be considered a spoiler
#
# s = Solver.load 100
# s.solve
#

class Solver < Struct.new(:board)

  def self.load(size)
    new Board.create size
  end

  def solve
    while population.size > 1
      ask_best!
    end
    guess! or fail "wrong :("
  end

  def population
    board.population
  end

  def guess!
    board.is_person? population.first['id']
  end

  def ask_best!
    k,v = best_query
    if board.person_has?(k,v)
      population.select! {|a| a[k] == v }
    else
      population.reject! {|a| a[k] == v }
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

require 'pry'
pry
