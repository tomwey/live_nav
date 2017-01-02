class Video < ActiveRecord::Base
  validates :name, :image, :live_url, presence: true
  
  has_many :favorites, as: :favoriteable
  has_many :bilibilis, as: :bilibiliable
  
  before_create :generate_vid
  def generate_vid
    begin
      n = rand(10)
      if n == 0
        n = 8
      end
      self.vid = n.to_s + SecureRandom.random_number.to_s[2..6]
    end while self.class.exists?(:vid => vid)
  end
  
  def bili_topic
    Digest::MD5.hexdigest("V:#{self.vid}")
  end
  
  def media_id
    self.vid
  end
  
  def add_view_count
    self.class.increment_counter(:view_count, self.id)
  end
  
end
