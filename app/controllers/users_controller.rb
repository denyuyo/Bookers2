class UsersController < ApplicationController

  def show
    @user = current_user
    @userid = User.find(params[:id])
    @book =Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user.id = current_user.id
    @book = save
    redirect_to book_path(@book)
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user)
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
    @users = User.all
  end

  def user_params
    params.require(:user).permit(:name, :introduction , :profile_image)
  end

  def is_matching_login_user
    user = current_user
    flash[:notice] = "Welcome! You have signed up successfully."
    unless user.id == current_user.id
      redirect_to root_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
