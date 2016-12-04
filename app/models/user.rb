require 'rest-client'
class User < ActiveRecord::Base  
  has_secure_password
  
  validates :mobile, :password, :password_confirmation, presence: true, on: :create
  validates :mobile, format: { with: /\A1[3|4|5|7|8][0-9]\d{4,8}\z/, message: "请输入11位正确手机号" }, length: { is: 11 }, :uniqueness => true
            
  mount_uploader :avatar, AvatarUploader
  
  scope :no_delete, -> { where(visible: true) }
  scope :verified,  -> { where(verified: true) }
  
  def hack_mobile
    return "" if self.mobile.blank?
    hack_mobile = String.new(self.mobile)
    hack_mobile[3..6] = "****"
    hack_mobile
  end
  
  def real_avatar_url(size = :large)
    if avatar.blank?
      "avatar/#{size}.png"
    else
      avatar.url(size)
    end
  end
  
  # 生成token
  before_create :generate_private_token
  def generate_private_token
    self.private_token = SecureRandom.uuid.gsub('-', '') if self.private_token.blank?
  end
  
  # 设置uid
  after_save :set_uid_if_needed
  def set_uid_if_needed
    if self.uid.blank?
      self.uid = 10000000 + self.id
      self.save!
      
      # 生成二维码
      # CreateQrcodeJob.perform_later(self)
    end
  end
  
  def appointed?(playlist)
    return false if playlist.blank?
    
    Appointment.where(playlist_id: playlist.id, user_id: self.id).count > 0
  end
  def appoint!(playlist)
    return false if playlist.blank?
    
    Appointment.create!(playlist_id: playlist.id, user_id: self.id)
  end
  
  def cancel_appoint!(playlist)
    return false if playlist.blank?
    
    Appointment.where(playlist_id: playlist.id, user_id: self.id).delete_all
  end
  
  def favorite!(favoriteable)
    return false if favoriteable.blank?
    
    Favorite.create!(favoriteable_id: favoriteable.id, favoriteable_type: favoriteable.class, user_id: self.id)
  end
  
  def unfavorite!(favoriteable)
    return false if favoriteable.blank?
    
    Favorite.where(favoriteable_id: favoriteable.id, favoriteable_type: favoriteable.class, user_id: self.id).delete_all
  end
  
  def favorited?(favoriteable)
    return false if favoriteable.blank?
    
    Favorite.where(favoriteable_id: favoriteable.id, favoriteable_type: favoriteable.class, user_id: self.id).count > 0
  end
  
  # 禁用账户
  def block!
    self.verified = false
    self.save!
  end
  
  # 启用账户
  def unblock!
    self.verified = true
    self.save!
  end
  
  # 设置支付密码
  # def pay_password=(password)
  #   self.pay_password_digest = BCrypt::Password.create(password) if self.pay_password_digest.blank?
  # end
  
  # 更新支付密码
  def update_pay_password!(password)
    return false if password.blank?
    self.pay_password_digest = BCrypt::Password.create(password)
    self.save!
  end
  
  # 检查支付密码是否正确
  def is_pay_password?(password)
    return false if self.pay_password_digest.blank?
    BCrypt::Password.new(self.pay_password_digest) == password
  end
  
end
