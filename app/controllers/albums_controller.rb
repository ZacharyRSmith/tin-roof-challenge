class AlbumsController < ApplicationController
  def show
    @album = Album.find params[:id]
    @photos = @album.photos
  end
end
