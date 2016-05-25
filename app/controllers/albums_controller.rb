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

  def edit
    @album = Album.find params[:id]
  end

  def new
    @album = Album.new
  end

  def update
    @album = Album.find params[:id]
    return render 'edit' unless @album.update_attributes album_params
    redirect_to @album
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
