module Round
  module_function

  ROUND_LENGTH = 20.minutes

  def current
    (duration / ROUND_LENGTH).ceil
  end

  def duration
    Time.now - ROUND_START
  end
end
