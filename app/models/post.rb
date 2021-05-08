class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :question, presence: true, length: { maximum: 140 }
  validates :answer, presence: true

  def comment(user)
    comments.where(user_id: user.id)
  end
end
