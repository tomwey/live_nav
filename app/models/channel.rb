class Channel < ActiveRecord::Base
  validates :name, :live_url
  mount_uploader :image, ImageUploader
  
  # 设置chn_id
  after_save :set_chn_id_if_needed
  def set_chn_id_if_needed
    if self.chn_id.blank?
      self.chn_id = 11000 + self.id
      self.save!
    end
  end
  
end
