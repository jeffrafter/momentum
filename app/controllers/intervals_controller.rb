class IntervalsController < ApplicationController
  before_filter :load_last_interval, :only => [:index, :create]

  def index
    @interval = Interval.new
    prepare
  end

  def categories
    cats = Interval.find(:all, 
      :select => 'category,count(*) as rank', 
      :group => 'category', 
      :order => 'rank DESC', 
      :conditions => ['category LIKE ?', '%' + params[:val] + '%'],
      :limit => 10)
    render :text => cats.map{|cat| {:text => cat.category}}.to_json
  end
  
  def create
    intervals = params[:intervals].sort rescue nil
    @interval = Interval.new
    @interval.comment = params[:comment]
    @interval.category = params[:category]
    @interval.category = @last_interval.category if params[:last]  
    @interval.ignore = params[:ignore].present?
    @interval.start_time = Time.parse(intervals.first).interval rescue nil
    @interval.end_time = Time.parse(intervals.last).next_interval rescue nil
    @interval.total_time = @interval.end_time - @interval.start_time rescue nil
    if @interval.save
      flash[:notice] = 'Success.'
      redirect_to '/'
    else  
      prepare
      flash[:notice] = 'Failure.'
      render :action => 'index' 
    end  
  end
  
private

  def load_last_interval
    @last_interval = Interval.last
    @activity = Activity.first unless @last_interval
    raise "You have not had any activity, please enable the momentum script" unless @last_interval || @activity  
  end

  def prepare
    @start_time = @last_interval ? @last_interval.end_time.interval : @activity.start_time.interval 
    @end_time = Time.now.interval 
    calculate_intervals
    calculate_stats(@start_time, @start_time == @end_time ? Time.now : @end_time, true)  
  end

  def calculate_intervals
    @intervals = []
    time = @start_time
    while (time < @end_time)
      @intervals << [time, time.next_interval]
      time = time.next_interval
    end
  end
  
  def calculate_stats(start_time, end_time, show_idle = true)
    @stats = Activity.stats(start_time, end_time)
    data = @stats.map{|stat| 
      if (show_idle)
        [Activity.bundle(stat.path), stat.total.to_f]
      else
        [Activity.bundle(stat.path), stat.total.to_f-stat.idle.to_f]
      end
    }
    @chart = GoogleChart.pie_3d_400x150(*data)
    @chart.background = 'bg,s,000000'
    @chart.colors = '0066CC'
    @chart_url = @chart.to_url
  end
end
