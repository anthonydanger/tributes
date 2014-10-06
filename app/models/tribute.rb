class Tribute < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	validates :name, presence: true
	validates :user_id, presence: true
	validates :obituary, presence: true#, length: { minimum: 20 }
	validates :dobirth, presence: true
	validates :dodeath, presence: true
  end
