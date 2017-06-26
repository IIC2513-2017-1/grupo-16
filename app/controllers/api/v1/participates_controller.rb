module Api::V1
  class ParticipatesController < ApiController
    before_action :authenticate
    before_action :is_current_user?, only: %i[multi_create]

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
      @numbers = params[:numbers]
      @raffle = Raffle.find(params[:raffle_id])
      @numbers.each do |n|
        print n
        @participate = Participate.new(user_id: params[:user_id], raffle_id: params[:raffle_id], number: n, confirmed: false)
        if not @participate.save
          render json: { errors: @participate.errors }, status: :unprocessable_entity
        end
      end
    end

    private

      def is_current_user?
        if User.find(params[:user_id]) != @current_user
          render json: {error: "The token provided doesn't match the one for the user requested."}
        end
      end
  end
end