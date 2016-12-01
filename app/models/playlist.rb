class Playlist < ActiveRecord::Base
  belongs_to :channel
  
  validates :name, :started_at, :ended_at, presence: true
  
  after_save :set_pl_id_if_needed
  def set_pl_id_if_needed
    if self.pl_id.blank?
      self.pl_id = 1000 + self.id
      self.save!
    end
  end
  
end
