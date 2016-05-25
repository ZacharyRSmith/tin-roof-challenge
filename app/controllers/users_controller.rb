class UsersController < ApplicationController
  def create
    @user = User.new user_params
    return render 'new' unless @user.save

    redirect_to root_url
  end

  def edit
    @user = User.find params[:id]
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

  def update
    @user = User.find params[:id]
    return render 'edit' unless @user.update_attributes user_params
    redirect_to @user
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
