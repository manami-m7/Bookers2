class BookComment < ApplicationRecord
  belongs_to :user_params
  belongs_to :book
end
