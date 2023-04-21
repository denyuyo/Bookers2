class Book < ApplicationRecord
  belongs_to :user

  validates :title, uniqueness: true,length: { minimum: 2, maximum: 20 }
  validates :body, length: { maximum: 200 }

  validates :title, presence: true
  validates :body, presence: true

end
