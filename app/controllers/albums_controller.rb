class AlbumsController < ApplicationController
  def destroy
    Album.find(params[:id]).destroy
    redirect_to root_url
  end

  def show
    @album = Album.find params[:id]
    @photos = @album.photos
  end
end
