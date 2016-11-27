class LiveStream < ActiveRecord::Base
  validates :name, :live_url, :image, presence: true
  mount_uploader :image, ImageUploader
  
  scope :opened, -> { where(opened: true) }
  scope :sorted, -> { order('sort desc, id desc') }
  
  # 设置sid
  after_save :set_sid_if_needed
  def set_sid_if_needed
    if self.sid.blank?
      self.sid = 10000 + self.id
      self.save!
    end
  end
end
