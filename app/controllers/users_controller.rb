class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  def new
    if logged_in?
      flash[:notice] = 'ログアウトしてから新規ユーザーを登録して下さい'
      redirect_to new_session_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path
    end
  end

  def show
    @user = User.find(params[:id])
    return redirect_to tasks_path if current_user.id != @user.id
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,
                                              :password_confirmation)
  end
end
