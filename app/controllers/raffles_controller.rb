class RafflesController < ApplicationController
  include Secured

  require 'rest-client'
  require 'openssl'
  require 'base64'
  require 'cgi'
  require 'oauth'

  before_action :set_raffle, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?, only: %i[new edit create update destroy]

  # GET /raffles
  # GET /raffles.json
  def index
    @raffles = Raffle.all
  end

  # GET /raffles/1
  # GET /raffles/1.json
  def show
    respond_to do |format|
      format.json do
        if !@raffle.winner_id
          render json: {
            raffle: @raffle,
            user: User.find(@raffle.user_id),
            numbers_bought: Participate.where("raffle_id = ?", @raffle.id).count,
            participate_exists: Participate.where("raffle_id = ? AND user_id= ?", @raffle.id, current_user.id).exists?,
            bookmark_exists: Bookmark.where("raffle_id = ? AND user_id= ?", @raffle.id, current_user.id).exists?,
            current_user: current_user
          }
        else
          render json: {
            raffle: @raffle,
            user: User.find(@raffle.user_id),
            numbers_bought: Participate.where("raffle_id = ?", @raffle.id).count,
            participate_exists: Participate.where("raffle_id = ? AND user_id= ?", @raffle.id, current_user.id).exists?,
            bookmark_exists: Bookmark.where("raffle_id = ? AND user_id= ?", @raffle.id, current_user.id).exists?,
            current_user: current_user,
            winner: User.find(@raffle.winner_id)
          }
        end
      end
    end
  end

  # GET /raffles/new
  def new
    @raffle = Raffle.new
  end

  # GET /raffles/1/edit
  def edit
  end

  # POST /raffles
  # POST /raffles.json
  def create
    @raffle = Raffle.new(raffle_params)
    @raffle.update(user_id: current_user.id)
    respond_to do |format|
      if @raffle.save
        status = 'Participa en la rifa ' + @raffle.name + '. Para visitarla ingresa a https://rifapp-web.herokuapp.com/raffles/' + @raffle.id
        access_token = prepare_access_token(ENV["TWITTER_ACCESS_TOKEN"], ENV["TWITTER_ACCESS_TOKEN_SECRET"])
        url = '/1.1/statuses/update.json?status=' + URI::escape(status)
        response = access_token.post(url)

        format.html { redirect_to created_user_path(current_user.id), notice: 'Raffle was successfully created.' }
        format.json { render :show, status: :created, location: @raffle }
      else
        format.html { render :new }
        format.json { render json: @raffle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /raffles/1
  # PATCH/PUT /raffles/1.json
  def update
    respond_to do |format|
      if @raffle.update(raffle_params)
        format.html { redirect_to created_user_path(current_user.id), notice: 'Raffle was successfully updated.' }
        format.json { render :show, status: :ok, location: @raffle }
      else
        format.html { render :edit }
        format.json { render json: @raffle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /raffles/1
  # DELETE /raffles/1.json
  def destroy
    @raffle.destroy
    respond_to do |format|
      format.html { redirect_to created_user_path(current_user.id), notice: 'Raffle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_raffle
      @raffle = Raffle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def raffle_params
      params.require(:raffle).permit(:name, :prize, :price, :finish_date, :max_number, :image)
    end

    def prepare_access_token(oauth_token, oauth_token_secret)
      consumer = OAuth::Consumer.new(ENV["TWITTER_KEY"], ENV["TWITTER_SECRET"], { :site => "https://api.twitter.com", :scheme => :header })

      token_hash = { :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret }
      access_token = OAuth::AccessToken.from_hash(consumer, token_hash )

      return access_token
    end
end
