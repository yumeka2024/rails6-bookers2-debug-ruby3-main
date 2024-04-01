class Notification < ApplicationRecord
  include Rails.application.routes.url_helpers
  # モデルの中でxxx_pathメソッドを使用するために必要な記述になります。

  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  def message
    if notifiable_type === "Book"
      "フォローしている#{notifiable.user.name}さんが#{notifiable.title}を投稿しました"
    else
      "投稿した#{notifiable.book.title}が#{notifiable.user.name}さんにいいねされました"
    end
  end

  def notifiable_path
    if notification.notifiable_type === "Book"
      book_path(notifiable.id) # 投稿に対する通知の場合はBookの詳細ページへ
    else
      user_path(notifiable.user.id) # いいねに対する通知の場合はいいねをしたUserの詳細ページへ
    end
  end

end
