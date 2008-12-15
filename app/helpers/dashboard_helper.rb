module DashboardHelper

  def options_for_intervals(intervals, selected = [])    
    if intervals.blank?
      return ""
    end
    content = ""
    last_interval_day = nil
    intervals.each{|interval|
      if interval.first.day != last_interval_day
        content << "<optgroup label='#{interval.first.strftime("%A, %B %e, %Y")}'>"
        last_interval_day = interval.first.day
      end
      text = format("#{interval.first.strftime("%I:%M")} - #{interval.last.strftime("%I:%M %p")}")
      value = "#{interval.first.strftime("%Y-%m-%d %H:%M")}"
      content << "\n"
      content << "<option class='#{cycle("even","odd")}' #{"selected='selected'" if selected.include?(value)} value='#{value}'>"
      content << "<span>#{text}</span>"
      content << "</option>"
    }
    content << "</optgroup>"
    content    
  end
  
  def format(text)
    text.gsub('AM', 'a.m.').gsub('PM', 'p.m.').gsub(/0(\d):/, '\1:')  
  end
  
end
