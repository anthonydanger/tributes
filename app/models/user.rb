class User < ActiveRecord::Base
	has_secure_password #(validations: false)
	before_save { email.downcase! }

	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

#  validates_presence_of     :password, :on => :create, :unless => :facebook_user?
#  validates_confirmation_of :password, :unless => :password.nil?

	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.avatar = auth.info.image
      user.password = auth.info.email
      user.password_confirmation = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def password_present?
    password_digest != nil && uid != nil
  end

  def facebook_user?
    provider != nil && uid != nil
  end
end
