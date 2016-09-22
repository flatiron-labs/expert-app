class User < ActiveRecord::Base

  has_many :expert_shifts
  has_many :shifts, through: :expert_shifts

  # def feedbacks

end
