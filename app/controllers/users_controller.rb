class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :show, :index]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
 
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
    @users = User.paginate :page => params[:page], :per_page => 5
  end
  
  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
end
