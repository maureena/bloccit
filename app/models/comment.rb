class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

   validates :body, length: { minimum: 5 }, presence: true
   validates :post_id, :user_id, presence: true
end
