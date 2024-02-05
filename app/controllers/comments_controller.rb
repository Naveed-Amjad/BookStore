class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  # before_action :authenticate_user!, only: [:edit, :update]
  

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @book = Book.find(params[:book_id])
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    # @comment = Comment.find_by(book_id: params[:id])
     @book = @comment.book
    # puts "#{@comment.id} is id of comment"
    # puts "#{@comment.book.id} ids are equal #{@comment.book.id} = #{params[:book_id]}  of book"
    # binding.break
    # begin
    #   if @comment.book.id == params[:book_id]
    #     @book = @comment.book
    #   end  
    # rescue ActiveRecord::RecordNotFound => e
    #     redirect_to '/404'
    # end 
          
    # puts " comment id = #{@comment.id} in edit method"
    # puts "book id = #{@book.id} in edit method"
    # binding.break
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to book_url(@comment.book), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(user_id: params[:comment][:user_id], book_id: params[:comment][:book_id], content: params[:comment][:content])
        format.html { redirect_to book_url(@comment.book), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to book_url(id: params[:book_id]), notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      begin
        @comment = Comment.find(params[:id])
        if @comment.book.id == params[:book_id].to_i
          @book = @comment.book
        else
          redirect_to '/404'
        end
      rescue ActiveRecord::RecordNotFound => e
        redirect_to '/404'
      end  
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:user_id, :book_id, :content)
    end

    def authenticate_user!
      unless user_signed_in? && (current_user.admin? || current_user.id == @comment.user_id)
        redirect_to login_path, alert: "You are not authorized to perform this action."
      end
    end
end
