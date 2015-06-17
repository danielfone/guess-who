class Scoreboard

  def board_count
    Board.count
  end

  def rounds
    @rounds ||= Board.distinct.pluck(:round).sort.each_with_object(Hash.new) do |round, h|
      h[round] = if round == Round.current
        calculate_score(round)
      else
        Rails.cache.fetch(['score', round]) { calculate_score round }
      end
    end
  end

  def teams
    @teams ||= Board.distinct.pluck(:team).sort
  end

private

  def calculate_score(round)
    scoring_scope.where(round: round).find_each.each_with_object(Hash.new(0)) do |p, h|
      h[p.team] += p.score
    end
  end

  def scoring_scope
    @scoring_scope ||= Board.select(:id, :solved, :size, :guesses, :team)
  end

end
