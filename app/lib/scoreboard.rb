class Scoreboard

  def scores
    puzzles.each_with_object(Hash.new(0)) do |p, h|
      h[p.team] += p.score
    end
  end

  def teams
    puzzles.map(&:team).uniq
  end

private

  def puzzles
    Puzzle.all
  end

end
