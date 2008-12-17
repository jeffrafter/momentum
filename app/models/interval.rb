class Interval < ActiveRecord::Base
  belongs_to :user
#  named_scope 'last', {:order => 'id DESC', :limit => 1}
  validates_presence_of :start_time, :end_time, :total_time, :category
  
  def description
    ignore ? 'ignored' : category
  end
end
