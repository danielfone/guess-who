class Scoreboard

  def sorted_scores
    scores.sort_by { |k,v| -v }
  end

  def scores
    # Don't load potentially huge `population` field
    current_boards.select(:id, :solved, :size, :guesses, :team).find_each.each_with_object(Hash.new(0)) do |p, h|
      h[p.team] += p.score
    end
  end

  def current_boards
    Board.where(round: Round.current)
  end

end
