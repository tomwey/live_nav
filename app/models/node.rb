class Node < ActiveRecord::Base
  
  validates :name, presence: true
  
  scope :opened, -> { where(opened: true) }
  scope :sorted, -> { order('sort desc, id desc') }
  
  # 设置chn_id
  after_save :set_node_id_if_needed
  def set_node_id_if_needed
    if self.nid.blank?
      self.nid = 1000 + self.id
      self.save!
    end
  end
end
