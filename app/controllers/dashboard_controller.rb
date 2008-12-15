class DashboardController < ApplicationController
  def index
    @interval = Interval.find(:all).last
    @activity = Activity.find(:first) unless @interval
    raise "You have not had any activity, please enable the momentum script" unless @interval || @activity
    @start_time = @interval ? @interval.end_time.interval : @activity.start_time.interval 
    @end_time = Time.now.interval 
    calculate_intervals
    calculate_stats    
  end

  def graph
  end
  
private

  def calculate_intervals
    @intervals = []
    time = @start_time
    while (time < @end_time)
      @intervals << [time, time.next_interval]
      time = time.next_interval
    end
  end
  
  def calculate_stats
    @stats = Activity.stats
    @chart = GoogleChart.pie_3d_400x150(*@stats.map{|stat| [Activity.bundle(stat.path), stat.total.to_f-stat.idle.to_f]})
    @chart.background = 'bg,s,000000'
    @chart.colors = '0066CC'
    @chart_url = @chart.to_url
  end
end
