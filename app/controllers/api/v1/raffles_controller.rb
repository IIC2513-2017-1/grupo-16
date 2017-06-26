module Api::V1
  class RafflesController < ApiController
    before_action :authenticate

    def create
      @raffle = @current_user.raffles.build(raffle_params)
      return if @raffle.save
      render json: { errors: @raffle.errors }, status: :unprocessable_entity
    end

    def show
      @raffle = Raffle.find(params[:id])
    end

    private

    def raffle_params
      params.require(:raffle).permit(:name, :prize, :price, :finish_date, :max_number, :image)
    end
  end
end
