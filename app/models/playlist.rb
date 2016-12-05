class Playlist < ActiveRecord::Base
  belongs_to :channel
  
  validates :name, :started_at, :ended_at, :channel_id, presence: true
  
  after_save :set_pl_id_if_needed
  def set_pl_id_if_needed
    if self.pl_id.blank?
      self.pl_id = 1000 + self.id
      self.save!
    end
  end
  
  def state
    now = Time.zone.now
    
    if self.ended_at < now
      -1 # 回看
    elsif self.started_at > now
      1  # 预告，预约
    else
      0  # 正在直播 
    end
  end
  
end
