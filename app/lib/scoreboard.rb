class Scoreboard

  def rounds_with_scores
    # :-O
    @rounds_with_scores ||= scores.each_with_object(Hash.new) {|((r,t),s),h| (h[r] ||= {})[t] = s }.sort.reverse
  end

  def velocity
    @velocity ||= Board.where(solved: true).where('created_at > ?', 5.seconds.ago).group('team').sum('size / guesses * 12')
  end

private

  def scores_for_round(round)
    Board.where(solved: true, round: round).group('team').order('sum_size_guesses DESC').sum('size / guesses')
  end

  def scores
    @scores ||= Board.where(solved: true).group('round', 'team').order('sum_size_guesses DESC').sum('size / guesses')
  end

end
