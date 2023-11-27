class HighScores
  def initialize(scores)
    @scores = scores
  end

  def scores
    @scores
  end

  def latest
    @scores[-1]
  end

  def personal_best
    @scores.max
  end

  def personal_top_three
    @scores.sort { |a, b| b <=> a }[...3]
  end

  def latest_is_personal_best?
    self.personal_best == self.latest
  end
end
