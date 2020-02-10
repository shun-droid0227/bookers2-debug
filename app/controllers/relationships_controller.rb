class RelationshipsController < ApplicationController

  before_action :set_user,{only: [:create, :destroy]}


  def create
    user = User.find(params[:follow_id])
    following = current_user.follow(user)
    if following.save
      flash[:success] = 'ユーザーをフォローしました'
      redirect_back(fallback_location: user)
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_back(fallback_location: user)
    end
  end

  def followings_show
    @book = Book.new
    @user = User.find(params[:id])
  end

  def followers_show
    @book = Book.new
    @user = User.find(params[:id])
  end

  def destroy
    user = User.find(params[:follow_id])
    following = current_user.unfollow(user)
    if following.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_back(fallback_location: user)
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_back(fallback_location: user)
    end
  end

  private

  def set_user
    user = User.find(params[:follow_id])
  end

end
