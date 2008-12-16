class Activity < ActiveRecord::Base
  belongs_to :user
  
  def self.stats(start_time = nil, end_time = nil) 
    options = {}
    options[:select] = 'path, SUM(total_time) as total, SUM(idle_time) as idle'
    options[:group] = 'path'
    options[:conditions] = ['start_time >= ? AND end_time <= ?', start_time, end_time] unless start_time.blank? || end_time.blank?
    self.find(:all, options)
  end
  
  def self.bundle(path)
    steps = path.split(/\//)
    steps.last.gsub(/.app/, '')
  rescue 
    path  
  end
end