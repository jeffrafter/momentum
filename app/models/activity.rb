class Activity < ActiveRecord::Base
  belongs_to :user
  
  def self.stats
    self.find(:all, :select => 'path, SUM(total_time) as total, SUM(idle_time) as idle', :group => 'path')
  end
  
  def self.bundle(path)
    steps = path.split(/\//)
    steps.last.gsub(/.app/, '')
  rescue 
    path  
  end
end