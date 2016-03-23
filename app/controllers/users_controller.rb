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
   
    private
     def user_params
        params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :region, :profile)
     end
     
     def limit_user
       @user = User.find(params[:id])
       redirect_to(root_url) unless @user == current_user
     end
end