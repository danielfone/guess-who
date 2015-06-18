class Scoreboard

  def board_count
    Board.count
  end

  def rounds
    @rounds ||= Board.distinct.order('round DESC').pluck(:round)
  end

  def rounds_with_scores
    @rounds_with_scores ||= rounds.each_with_object({}) do |round, h|
      h[round] = scores_for_round(round)
    end
  end

  def velocity
    @velocity ||= Board.where(solved: true).where('created_at > ?', 1.minute.ago).group('team').sum('size / guesses')
  end

private

  def scores_for_round(round)
    Board.where(solved: true, round: round).group('team').order('sum_size_guesses DESC').sum('size / guesses')
  end

end
