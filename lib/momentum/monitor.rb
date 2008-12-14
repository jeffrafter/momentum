module Momentum
  class NoCurrentActivityError < RuntimeError; end

  class Monitor
    cattr_accessor :default

    attr_accessor :activity
    attr_accessor :spans
    attr_accessor :idle
  
    def initialize
      self.activity = nil
      self.idle = Momentum::Span.new(Time.now, Time.now)
      self.spans = []
    end
  
    def self.setup(&block)              
      self.default = yield block
    end
  
    def self.process
      self.default.send(:process_idle)
      self.default.send(:process_activity)
    end
  
    def focus(path, application, window)
      blur 
      self.activity = Activity.new(
        :user => Config.user,
        :start_time => Time.now,
        :path => path,
        :application => application,
        :window => window)
      self.spans = []
      self.idle = Momentum::Span.new(Time.now, Time.now)
    end

    def blur
      return unless self.activity
      self.idle.end_time = Time.now
      self.spans << self.idle
      significant_spans = self.spans.select {|span| span.significant? }
      self.activity.end_time = Time.now      
      self.activity.idle_time = significant_spans.sum{|span| span.duration }
      self.activity.save!      
      puts "#{self.activity.path} (#{self.activity.application}): #{self.activity.window} (#{self.activity.idle_time} idle)" if Config.verbose
    end
    
  private
  
    def process_idle
      if (Config.checker.current_idle_time < Config.interval)
        self.idle.end_time = Time.now      
        self.spans << self.idle
        self.idle = Momentum::Span.new(Time.now, Time.now)
      end    
    end
    
    def process_activity
      app = Config.checker.current_application
      if (self.activity.blank? || 
          self.activity.path != app[:path] || 
          self.activity.application != app[:name] || 
          self.activity.window != app[:window])
        focus(app[:path], app[:name], app[:window])
      end    
    end    
  end
end