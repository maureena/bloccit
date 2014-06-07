class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :posts
  has_many :comments
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  def role?(base_role)
    role == base_role.to_s
  end

  def favorited(post)
    self.favorites.where(post_id: post.id).first
  end

  def voted(post)
    self.votes.where(post_id: post.id).first
  end

  def self.top_rated
    self.select('users.*'). # Selects all attributes of the user
      select('COUNT(DISTINCT comments.id) AS comments_count'). # Counting comments made by the user
      select('COUNT(DISTINCT posts.id) AS posts_count'). # Counting posts by user
      select('COUNT(DISTINCT comments.id) + COUNT(DISTINCT posts.id) AS rank'). # Add comment count to post count and label sum as "rank"
      joins(:posts). # Ties posts table to users table via user_id
      joins(:comments). # Ties comments table to users table via user_id
      group('users.id'). # Tells database to group results so each user will be returned in distinct row
      order('rank DESC') # Tells database to order results by descension by rank sum created above
  end

end
