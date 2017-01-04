class LiveStream < ActiveRecord::Base
  validates :name, :live_url, :image, presence: true
  mount_uploader :image, ImageUploader
  
  has_many :favorites, as: :favoriteable
  has_many :bilibilis, as: :bilibiliable
  
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
  
  def bili_topic
    Digest::MD5.hexdigest("LS:#{self.sid}")
  end
  
  def real_image
    if image.blank?
      ''
    else
      image.url(:thumb)
    end
  end
  
  def media_id
    self.sid
  end
  
  def add_view_count
    self.class.increment_counter(:view_count, self.id)
  end
  
end
