class AlbumsController < ApplicationController
  def create
    @user = User.find params[:album][:user_id]
    @album = Album.new album_params
    return render 'new' unless @album.save

    redirect_to @user
  end

  def destroy
    Album.find(params[:id]).destroy
    redirect_to root_url
  end

  def new
    @album = Album.new
  end

  def show
    @album = Album.find params[:id]
    @photos = @album.photos
  end

  private

    def album_params
      params.require(:album).permit(:user_id, :title)
    end
end
