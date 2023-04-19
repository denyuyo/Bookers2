class Book < ApplicationRecord
  belongs_to :user
  
  validates :body,
       length: { minimum: 0, maximum: 200 }
  
  validates :title, presence: true
  validates :body, presence: true
end
