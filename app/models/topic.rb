class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  scope :visible_to, ->(user) { user ? all : where(public: true) }
end
