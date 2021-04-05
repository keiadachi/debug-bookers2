class UsersController < ApplicationController

  before_action :ensure_correct_user, only:[:edit]


  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @relationship = @user.followings.find_by(follower_id: current_user.id)
  end

  def index
    #binding.pry
    @user = current_user
    @users = User.all
    @book = Book.new
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:user] = "You have updated user successfully."
      redirect_to user_path(current_user)
    else
      render action: :edit
    #current_userで個人へ遷移
    end
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followers.map {|follow|  User.find(follow.followed_id)}
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followings.map {|follow| User.find(follow.follower_id)}
  end



  private

  def ensure_correct_user
    @user = User.find(params[:id])
     unless @user == current_user
     redirect_to user_path(current_user)
     end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end


end