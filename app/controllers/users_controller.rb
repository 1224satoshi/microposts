class UsersController < ApplicationController
   before_action :logged_in_user, only: [:edit, :update]
   before_action :limit_user, only: [:edit, :update]
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
   
   def edit
   end
   
   def update
       if @user.update_attributes(user_params)
        flash[:success] = "Your Account was updated!"
        redirect_to @user
       else
         render 'edit'
       end
   end
   
   def followings
        @users = current_user.follower_users
        render 'show_followings'
   end
   
   def followers
        @users = current_user.following_users
        render 'show_followers'
   end

   
    private
     def user_params
        params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :region, :profile)
     end
     
     def limit_user
       @user = User.find(params[:id])
       redirect_to(root_url) unless @user == current_user
     end

  private

     def user_params
       params.require(:user).permit(:name, :email, :password,
                                    :password_confirmation)
     end
end
