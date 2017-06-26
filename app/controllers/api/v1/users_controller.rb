module Api::V1
  class UsersController < ApiController
    before_action :authenticate
    before_action :is_current_user?

    def show
    end

    def created
      @raffles = @current_user.raffles
    end

    def available
      @raffles = Raffle.all
    end

    def participating
      @raffles = []
      @current_user.participates.group_by{ |part| part.raffle_id }.keys.each do |r|
        @raffles.push(Raffle.find(r))
      end
    end

    def bookmarked
      @raffles = []
      @current_user.bookmarks.each do |b|
        @raffles.push(Raffle.find(b.raffle.id))
      end
    end

    private

      def is_current_user?
        if User.find(params[:id]) != @current_user
          render json: {error: "The token provided doesn't match the one for the user requested."}
        end
      end
  end
end
