class Shift < ActiveRecord::Base

  has_many :schedules
  has_many :users, through: :schedules

  validates :start_time, :end_time, presence: true

end
