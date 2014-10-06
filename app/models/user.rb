class User < ActiveRecord::Base
  has_many :tributes, dependent: :destroy
  attr_accessor :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest

  self.per_page = 10 # For will_paginate
  has_secure_password #(validations: false)
	
  before_create :create_remember_token

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

  def create_reset_digest
    self.reset_token = User.new_remember_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver
  end
 
  def password_present?
    password_digest != nil && uid != nil
  end

  def facebook_user?
    provider != nil && uid != nil
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    BCrypt::Password.new(digest).is_password?(token)
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

    def downcase_email
      self.email = email.downcase
    end

    def create_activation_digest
      self.activation_token  = User.new_remember_token
      self.activation_digest = User.digest(activation_token)
    end 

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
