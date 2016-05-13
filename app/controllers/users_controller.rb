class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash.now[:success] = "New user created!"
      redirect_to @user 
    else
      flash.now[:danger] = "Try again!"
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @upcoming_events = @user.upcoming_events
    @past_events = @user.past_events
  end
  
  def index
    @users = User.all
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
