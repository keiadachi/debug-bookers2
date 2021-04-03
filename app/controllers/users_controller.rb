class UsersController < ApplicationController

  before_action :ensure_correct_user, only:[:edit]



  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
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