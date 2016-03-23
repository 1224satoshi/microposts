class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :followings, :followers]
  
  def show 
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc)
  end
  
  
  def new
    @user = User.new
  end
  
  
   def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user #　ここを修正
    else
      render 'new'
    end
   end
   
   def followings
       @user = User.find(params[:id])
       render 'show_followings'
   end
   
   def followers
        @user = User.find(params[:id])
        @users = @user.followers.order
        render 'show_followers'
   end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
