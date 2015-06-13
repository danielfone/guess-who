class Scoreboard

  def scores
    # Don't load potentially huge `population` field
    Board.select(:id, :solved, :size, :guesses, :team).find_each.each_with_object(Hash.new(0)) do |p, h|
      h[p.team] += p.score
    end
  end

end
