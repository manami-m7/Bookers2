class Book < ApplicationRecord

  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
  validates :body, length: { maximum: 200 }
  
  validates :name, uniqueness: true
  validates :name, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }
end
