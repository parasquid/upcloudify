class Numeric
  def hour
    self * 3600
  end
  alias_method :hours, :hour

  def day
    self * 24.hours
  end
  alias_method :days, :day
end

class Time
  def tomorrow
    self + 1.day
  end
end