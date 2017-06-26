module Api::V1
  class ParticipatesController < ApiController
    before_action :authenticate

    def multi_new
      taken = Participate.where("raffle_id = ?", params[:raffle_id]).pluck("number")
      @raffle = Raffle.find(params[:raffle_id])
      @available = []
      (1..Raffle.find(params[:raffle_id]).max_number).each do |i|
        if not taken.include?(i)
          @available.push(i)
        end
      end
    end

    def multi_create

    end
  end
end