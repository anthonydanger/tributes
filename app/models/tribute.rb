class Tribute < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	#has_many :active_relationships, class_name: "Relationship",
  #                                foreign_key: "follower_id",
  #                                dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  #has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
	validates :name, presence: true
	validates :user_id, presence: true
	validates :obituary, presence: true#, length: { minimum: 20 }
	validates :dobirth, presence: true
	validates :dodeath, presence: true
  end
