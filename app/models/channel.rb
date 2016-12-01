class Channel < ActiveRecord::Base
  validates :name, :live_url, :image, presence: true
  mount_uploader :image, ImageUploader
  
  has_and_belongs_to_many :nodes
  
  scope :opened, -> { where(opened: true) }
  scope :sorted, -> { order('sort desc, id desc') }
  
  # 设置chn_id
  after_save :set_chn_id_if_needed
  def set_chn_id_if_needed
    if self.chn_id.blank?
      self.chn_id = 11000 + self.id
      self.save!
    end
  end
  
  def add_view_count
    self.class.increment_counter(:view_count, self.id)
  end
  
end
