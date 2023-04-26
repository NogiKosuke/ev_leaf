class Admin::UsersController < ApplicationController
  def index
    @users = User.all.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'ユーザーを作成しました'
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'ユーザーを編集しました'
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = 'ユーザーを削除しました'
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,
                                              :password_confirmation)
  end
end
