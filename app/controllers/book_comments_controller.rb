class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    if comment.save
      redirect_to book_path(book)
    else
      redirect_to book_path(book)
    end
  end

  def destroy
    book = Book.find(params[:id])
    comment = current_user.book_comments.find_by(book_id: book.id)
    comment.destroy
    redirect_to book_path(book)
  end

  private
  def book_comment_params
      params.require(:book_comment).permit(:user_id,:book_id,:comment)
  end

end
