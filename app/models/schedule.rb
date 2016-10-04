class Schedule < ActiveRecord::Base

  belongs_to :user
  belongs_to :shift

  validates_uniqueness_of :user_id, :scope => :shift_id

end
