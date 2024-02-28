class BookCommentsController < ApplicationController
  before_action :is_matching_login_user, only: [:destroy]
  
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_to book_path(book.id)
  end
  
  def destroy
    Book.find(params[:book_id]).destroy
    redirect_to book_path(book.id)
  end
  
  
  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
  
  #ログインユーザーと一致しないとアクセスさせない
  def is_matching_login_user
    book = Book.find(params[:id])
    user = book.user
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
  
end
