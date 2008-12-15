class Interval < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  named_scope 'last', {:order => 'id DESC', :limit => 1}
end
