class BooksController < ApplicationController
  before_action :ensure_correct_user, only:[:edit]


  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
  end

  def edit
     @book = Book.find(params[:id])
     if @book.user != current_user
       redirect_to :books
     end
  end

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def create
     @book = Book.new(book_params)
     @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def update
     @book = Book.find(params[:id])
     if @book.user != current_user
       redirect_to books_path
     end
      if @book.update(book_params)
        flash[:notice] = "Book was successfully updated."
        redirect_to book_path(@book)
      else
        render :edit
      end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path
  end


  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book =Book.find(params[:id])
     unless @book.user == current_user
     redirect_to user_path(user.id)
     end
  end
end