class Participate < ActiveRecord::Base
	belongs_to :raffle
	belongs_to :user
end
