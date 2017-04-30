class User < ActiveRecord::Base
	validates :password, presence: true, length: { minimum: 6 }, confirmation: true, allow_blank: false
	validates :email, presence: true, uniqueness: true, allow_blank: false, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

	has_many :raffles
	has_many :sorteos

	has_many :participate_relationships, foreign_key: :raffle_id, class_name: 'Participate'
end
