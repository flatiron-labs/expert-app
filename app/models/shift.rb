class Shift < ActiveRecord::Base

  has_many :expert_shifts
  has_many :users, through: :expert_shifts

  

end
