class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:id])
    comment = current_user.book_comments.new
    comment.book_id = @book.id
    comment.comment = params[:comment]
    comment.save
  end

  def destroy
    @book = Book.find(params[:id])
    comment = current_user.book_comments.find_by(book_id: @book.id)
    comment.destroy
  end

  private
  def book_comment_params
      params.require(:book_comment).permit(:user_id,:book_id,:comment)
  end

end
