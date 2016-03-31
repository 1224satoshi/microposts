class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :search
  include SessionsHelper
  
  def search
    @q = Micropost.ransack(params[:q])
    @commits = @q.result(distinct: true)
   end

private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end