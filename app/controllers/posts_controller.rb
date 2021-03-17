class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.order(id: :desc).page(params[:page]).per(5)
  end
  def show
    @post = Post.find(params[:id])
  end
  def new
    @post = Post.new
  end
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '口コミが投稿されました！'
      redirect_to @post
      # showルーティング（posts/:id）に飛ばす
    else
      @posts = current_user.posts.order(id: :desc).page(params[:page])
      flash.now[:danger] = '投稿に失敗しました。'
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = '口コミ内容が更新されました'
      redirect_to @post
    else
      flash[:danger] = '口コミ内容の更新に失敗しました。'
      render :edit
    end
  end
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:danger] = '口コミを削除しました。'
    redirect_to root_url
  end

  private
  
  def post_params
    params.require(:post).permit(:content, :title, :subject, portraits: [])
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
