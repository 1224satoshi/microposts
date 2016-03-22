class UsersController < ApplicationController
   before_action :logged_in_user, only: [:edit, :update]
   before_action :limit_user, only: [:edit, :update]
  
   def show # 追加
   @user = User.find(params[:id])
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
     @user = User.find(params[:id])
   end
   
   def update
     @user = User.find(params[:id])
      if @user.update_attributes(user_params)
       flash[:success] = "Your Account was updated!"
       redirect_to @user
      else
        render 'edit'
      end
   end
   
    def logged_in_user
       unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
       end
    end
    
    def limit_user
       @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
    private
     def user_params
     params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :region, :profile)
     end
end