class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
    @books = Book.page(params[:page])
  end

  def edit
     @book = Book.find(params[:id])
  end

  def index
    @books = Book.page(params[:page])
    @user = current_user
    @book = Book.new
  end

  def create
     @book = Book.new(book_params)
     @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def update
     @book = Book.find(params[:id])
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
end