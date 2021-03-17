class UsersController < ApplicationController
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
  
  private


  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password,:password_confirmation)
  end
end
