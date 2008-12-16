module ApplicationHelper

  def options_for_intervals(intervals, start_time = nil, end_time = nil)    
    if intervals.blank?
      return "<optgroup label='Nothing to categorize, wait a couple minutes, relax.'><option disabled='disabled'/></optgroup>"
    end
    content = ""
    select_all = start_time.blank? || end_time.blank?
    last_interval_day = nil
    intervals.each{|interval|
      if interval.first.day != last_interval_day
        content << "<optgroup label='#{interval.first.strftime("%A, %B %e, %Y")}'>"
        last_interval_day = interval.first.day
      end
      text = display(interval)
      value = "#{interval.first.strftime("%Y-%m-%d %H:%M")}"
      content << "\n"
      content << "<option class='#{cycle("even","odd")}' #{"selected='selected'" if select_all || (interval.first >= start_time && interval.last <= end_time)} value='#{value}'>"
      content << "<span>#{text}</span>"
      content << "</option>"
    }
    content << "</optgroup>"
    content    
  end
  
  def display(interval)
    format("#{interval.first.strftime("%I:%M")} - #{interval.last.strftime("%I:%M %p")}")  
  end
  
  def format(text)
    text.gsub('AM', 'a.m.').gsub('PM', 'p.m.').gsub(/0(\d):/, '\1:')  
  end
  
end