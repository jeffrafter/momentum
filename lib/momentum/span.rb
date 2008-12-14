module Momentum
  class Span
    attr_accessor :start_time, :end_time
    
    def initialize(start_time, end_time)
      self.start_time = start_time
      self.end_time = end_time
    end
    
    def duration
      self.end_time - self.start_time
    end
    
    def significant?
      self.duration > Momentum::Config.significant_idle_time
    end
  end
end  