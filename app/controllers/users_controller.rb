class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    @book =Book.new
    @books = @user.books
  end

  def edit
   @user = User.find(params[:id])
   if @user != current_user
       redirect_to user_path(current_user)
   end
  end

  def update
    @user = User.find(params[:id])
  if  @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
  else
    render :edit
  end
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
    @users = User.all
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction , :profile_image)
  end

  def is_matching_login_user
    user = current_user
    flash[:notice] = "Welcome! You have signed up successfully."
    unless user.id == current_user.id
      redirect_to book_path(current_user.id)
    end
  end

end