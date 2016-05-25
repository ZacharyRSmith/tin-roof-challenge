class UsersController < ApplicationController
  def create
    @user = User.new user_params
    return render 'new' unless @user.save

    redirect_to root_url
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find params[:id]
    @albums = @user.albums
  end

  private

    def user_params
      params.require(:user).permit(
        :name,
        :username,
        :email,
        :phone,
        :website)
    end
end
