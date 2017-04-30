class Raffle < ActiveRecord::Base
	validates :name, presence: true, allow_blank: false
	validates :prize, presence: true, allow_blank: false
	validates :price, presence: true, allow_blank: false
	validates :finish_date, presence: true, allow_blank: false

	belongs_to :user
end
