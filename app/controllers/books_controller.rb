class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :user_exist, only: [:new]

  # GET /books or /books.json
  def index
    @books = Book.all
  end

  # GET /books/1 or /books/1.json
  def show
    @book = Book.find(params[:id])
    @comments = @book.comments
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    #puts " this book belong to the user with user user_id #{@book.user} user"
    #binding.break
  end

  # POST /books or /books.json
  def create
    @book = current_user.books.new(book_params)
   # @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    authorize @book

    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy

    @book = Book.find(params[:id])
    authorize @book

    @book.destroy!

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      begin
        @book = Book.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        redirect_to '/404'
      end  
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :description, :user_id, :image)
      # binding.break
    end

    def user_exist
      begin
        authorize Book.new, :create?
      rescue Pundit::NotAuthorizedError
        redirect_to new_user_session_path
      end
    end
end
