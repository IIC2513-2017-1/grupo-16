class Raffle < ActiveRecord::Base
	validates :name, presence: true, allow_blank: false
	validates :prize, presence: true, allow_blank: false
	validates :price, presence: true, allow_blank: false
	validates :finish_date, presence: true, allow_blank: false
	validates :max_number, numericality: { greater_than: 0 }

	belongs_to :user
	has_many :participates
	has_many :bookmarks
	has_many :comments

	mount_uploader :image, ImageUploader
end
