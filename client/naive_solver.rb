require_relative './board'
#
# This is a reference implementation for solving the board
# and may be considered a spoiler
#
# s = Solver.load 'my-team', 100
# s.solve
#

class Solver < Struct.new(:board)

  def self.load(team, size)
    new Board.create team, size
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
    k,v = random_question
    if board.person_has?(k,v)
      population.select! {|a| a[k] == v }
    else
      population.reject! {|a| a[k] == v }
    end
  end

  def random_question
    population.sample.reject{|k,v| k == "id"}.to_a.sample
  end

end
