class BookmarksController < ApplicationController
  
  # POST /bookmark
  # POST /bookmarks.json
  def create
    @bookmark = Bookmark.new(bookmark_params)

    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to bookmarked_user_path(params[:user_id]), notice: 'Rifa guardada' }
        format.json { render bookmarked_user_path(params[:user_id]), status: :created, location: @bookmark }
      else
        format.html { render :new }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmark/1
  # DELETE /bookmarks/1.json
  def destroy
    @bookmark = Bookmark.where("user_id = ? AND raffle_id = ?", params[:user_id], params[:raffle_id]).first
    @bookmark.destroy
    respond_to do |format|
      format.html { redirect_to bookmarked_user_path(params[:user_id]), notice: 'Rifa removida de guardadas' }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookmark_params
      params.permit(:user_id, :raffle_id)
    end
end
