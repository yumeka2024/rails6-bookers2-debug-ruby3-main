class Favorite < ApplicationRecord
  
  belongs_to :user, optional:true
  belongs_to :book, optional:true
  has_one :notification, as: :notifiable, dependent: :destroy
  
  validates :user_id, uniqueness: {scope: :book_id}
  
  after_create do
    create_notification(user_id: book.user_id)
  end
  
end
