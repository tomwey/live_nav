class Playlist < ActiveRecord::Base
  belongs_to :channel
  
  validates :name, :started_at, :ended_at, presence: true
  
end
