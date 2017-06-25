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
        status = 'Participa en la rifa ' + @raffle.name
        access_token = prepare_access_token("579380079-ubQFIQTWe6dmkjC5V1wYJ4Vm5bPr4pJyWmDy7No0", "AwM1BED4aFHGKOssNxt8tsw85VavlyEGnKiC3QfPr2lgA")
        response = access_token.post('/1.1/statuses/update.json', {"status" => status}.to_json)
        puts response


        now = Time.now.to_i
        status_encoded = URI::escape(status)
        url_encoded = URI::escape('https://api.twitter.com/1.1/statuses/update.json')
        nonce = SecureRandom.hex(24)
        param_string = 'include_entities=true&oauth_consumer_key=PQGHygKGiSK3VPiPGaoKr8iwk&oauth_nonce=' + nonce + '&oauth_signature_method=HMAC-SHA1&oauth_timestamp=' + now.to_s + '&oauth_token=579380079-ubQFIQTWe6dmkjC5V1wYJ4Vm5bPr4pJyWmDy7No0&oauth_version=1.0&status=' + status_encoded
        param_string_encoded = URI::escape(param_string)
        signature_base_string = 'POST&' + url_encoded + '&' + param_string_encoded
        signing_key = 'ix8kqsQk2oen9qJ52lmxUCyPwnZdLvnfgmwGXOjvDA6D9wUr1v&AwM1BED4aFHGKOssNxt8tsw85VavlyEGnKiC3QfPr2lgA'
        #signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha1'), signing_key, signature_base_string)
        signature = CGI.escape(Base64.encode64("#{OpenSSL::HMAC.digest('sha1',signing_key, signature_base_string)}\n"))
        auth = 'OAuth oauth_consumer_key="PQGHygKGiSK3VPiPGaoKr8iwk", oauth_nonce="' + nonce + '", oauth_signature="' + URI::escape(signature) + '", oauth_signature_method="HMAC-SHA1", oauth_timestamp="' + now.to_s + '", oauth_token="579380079-ubQFIQTWe6dmkjC5V1wYJ4Vm5bPr4pJyWmDy7No0", oauth_version="1.0"'
        status_json = {"status": status}
        #RestClient::Request.execute(method: :post, url: 'https://api.twitter.com/1.1/statuses/update.json?include_entities=true', payload: status_json.to_json.to_s, headers: {"Authorization" => auth})

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
      consumer = OAuth::Consumer.new("PQGHygKGiSK3VPiPGaoKr8iwk", " ix8kqsQk2oen9qJ52lmxUCyPwnZdLvnfgmwGXOjvDA6D9wUr1v", { :site => "https://api.twitter.com", :scheme => :header })

      token_hash = { :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret }
      access_token = OAuth::AccessToken.from_hash(consumer, token_hash )

      return access_token
    end
end
