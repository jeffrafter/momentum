class Time
  # Dividing time into intervals allows you to quickly set up periods. Calling 
  # interval on a time will return the start time of the current interval 
  # which is assumed to start on the hour. The value for step should be a 
  # factor of 60.
  def interval(step = 6)
    Time.mktime(year, month, day, hour, min - (min % step), 0)
  end
  
  # Grabs the start time of the next interval (see +interval+ for more details)
  def next_interval(step = 6)  
    (self + step.minutes).interval(step)
  end  
end