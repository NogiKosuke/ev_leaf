class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_required

  private

  def login_required
    unless current_user
      flash[:danger] = "ログインをして下さい"
      redirect_to new_session_path 
    end
  end
end
