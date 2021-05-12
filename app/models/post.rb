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

  def self.search(search)
    return all if search.blank?
    search_tag("kind", search[:kind])
      .search_tag("media", search[:media])
      .search_tag("series", search[:series])
      .search_tag("belong", search[:belong])
      .search_tag("group", search[:group])
      .search_tag("geography", search[:geography])
      .search_tag("category", search[:category])
  end

  def self.search_tag(column, params)
    params.blank? ? all : where(column => params)
  end

  def options
    return if kind == "自由記述"
    return answer.split("　").shuffle if kind == "一問一答" || kind == "並び替え"
  end

  def correct
    return answer if kind == "自由記述"
    return answer.split("　").first if kind == "一問一答"
    return answer.split("　").join(" → ") if kind == "並び替え"
  end
end
