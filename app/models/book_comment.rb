class BookComment < ApplicationRecord
  
  belongs_to :user, optional:true
  belongs_to :book, optional:true
  
  validates :comment, presence:true, length:{maximum:200}
  
end
