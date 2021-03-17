class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update]
  before_action :correct_user, only: [:show, :edit, :update]
  def index
    @users = User.order(id: :desc).page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザを更新しました。'
      redirect_to @user
    else
      flash[:danger] = 'ユーザの更新に失敗しました。'
      render :edit
    end
  end

  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.page(params[:page])
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :nickname, :profile_image, :email, :password,:password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
  end
end
