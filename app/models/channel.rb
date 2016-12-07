class Channel < ActiveRecord::Base
  validates :name, :live_url, :image, presence: true
  mount_uploader :image, ImageUploader
  
  has_and_belongs_to_many :nodes
  has_many :favorites, as: :favoriteable
  has_many :bilibilis, as: :bilibiliable
  has_many :playlists, dependent: :destroy
  
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
  
  def media_id
    self.chn_id
  end
  
  def add_playlists!
    PlaylistsData.import(self.id)
  end
  
  def online
    true
  end
  
  def bili_topic
    Digest::MD5.hexdigest("C:#{self.chn_id}")
  end
  
  def add_view_count
    self.class.increment_counter(:view_count, self.id)
  end
  
  def current_playlist
    @current_playlist ||= playlists.where('started_at >= :time and ended_at < :time', time: Time.zone.now).first
  end
  
  def playlists_for_offset(offset = 0)
    date = Time.zone.now + offset.days
    playlists.where(started_at: date.beginning_of_day..date.end_of_day).order('started_at asc')
  end
  
end
