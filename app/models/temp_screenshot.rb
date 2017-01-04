class TempScreenshot < ActiveRecord::Base
  belongs_to :channel
  
  validates :image, :upload_at, presence: true
  
  mount_uploader :image, ImageUploader
end
