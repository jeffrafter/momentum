class Interval < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :start_time, :end_time, :total_time, :category
  
  def description
    ignore ? 'ignored' : category
  end
end
