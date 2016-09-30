class User < ActiveRecord::Base

  has_many :schedules
  has_many :shifts, through: :schedules

  # def feedbacks
  def self.find_or_create_by_full_name(full_name)
    name_array = full_name.split(" ")
    first_name = name_array[0]
    last_name = name_array[1]
    find_or_create_by(first_name: first_name, last_name: last_name)
  end

end
