module Api::V1
  class UsersController < ApiController
    before_action :authenticate

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
        @raffles.push(Raffle.find(r.id))
      end
    end

    def bookmarked
      @raffles = []
      @current_user.bookmarks.each do |b|
        @raffles.push(Raffle.find(b.raffle.id))
      end
    end
  end
end
