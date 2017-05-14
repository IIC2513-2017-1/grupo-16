class User < ActiveRecord::Base
	has_secure_password

	validates :password, presence: true, length: { minimum: 6 }, confirmation: true, allow_blank: false
	validates :email, presence: true, uniqueness: true, allow_blank: false, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

	has_many :raffles
	has_many :sorteos
	has_many :participates
	has_many :bookmarks
	has_many :comments

	def full_name
    	"#{first_name} #{last_name}"
  	end
end
