class Schedule < ActiveRecord::Base

  has_many :users
  has_many :shifts

  validates_uniqueness_of :user_id, :scope => :shift_id

end
