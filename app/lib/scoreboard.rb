class Scoreboard

  def scores
    boards.each_with_object(Hash.new(0)) do |p, h|
      h[p.team] += p.score
    end
  end

  def teams
    boards.map(&:team).uniq
  end

private

  def boards
    Board.all
  end

end
