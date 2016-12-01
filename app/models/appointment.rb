class Appointment < ActiveRecord::Base
  belongs_to :playlist, counter_cache: true
  belongs_to :user
end
