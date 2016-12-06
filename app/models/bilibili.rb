class Bilibili < ActiveRecord::Base
  belongs_to :user
  belongs_to :bilibiliable, polymorphic: true
  
  validates :content, :user_id, presence: true
  
  after_create :push_message
  def push_message
    SendBiliJob.perform_later(self.content, self.bilibiliable.bili_topic)
  end
end
