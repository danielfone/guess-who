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
    Board.where(solved: true, round: round).group('team').order('sum_size_guesses DESC').sum('size / guesses')
  end

end
