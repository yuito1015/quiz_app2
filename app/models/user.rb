class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_follows, source: :followed
  has_many :followers, through: :passive_follows, source: :follower

  has_many :comments, dependent: :destroy
  has_many :comment_posts, through: :comments, source: :post

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  default_scope -> { order created_at: :desc }
  validates :name, presence: true, uniqueness: { message: "はすでに使われています" }
  validates :image_name, presence: true
  has_secure_password
  validates :password, presence: true, allow_nil: true

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_follows.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def ordered_following
    following.reorder("follows.created_at desc")
  end

  def comment?(post)
    comment_posts.include?(post)
  end

  def ordered_comment_posts
    comment_posts.group(:id).reorder("max(comments.created_at) desc")
  end

  def like(post)
    liked_posts << post
  end

  def unlike(post)
    likes.find_by(post_id: post.id).destroy
  end

  def like?(post)
    liked_posts.include?(post)
  end

  def ordered_liked_posts
    liked_posts.reorder("likes.created_at desc")
  end
end
