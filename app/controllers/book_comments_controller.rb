class BookCommentsController < ApplicationController
  before_action :is_matching_login_user, only: [:destroy]

  def create
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.new
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = @book.id
    comment.save
    # redirect_to book_path(book.id)
  end

  def destroy
    @book = Book.find(params[:book_id])
    @comment = BookComment.find(params[:id])
    @comment.destroy
    # redirect_to @book_path(book.id)
  end


  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  #ログインユーザーと一致しないとアクセスさせない
  def is_matching_login_user
    comment = BookComment.find(params[:id])
    user = comment.user
    unless user.id == current_user.id
      redirect_to books_path
    end
  end

end
