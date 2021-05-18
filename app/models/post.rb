class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  default_scope -> { order created_at: :desc }
  validates :user_id, presence: true
  validates :question, presence: true, length: { maximum: 140 }
  validates :answer, presence: true

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

  def comment(user)
    comments.where(user_id: user.id)
  end

  def options
    case kind
    when "自由記述"
      return
    when "一問一答", "並び替え"
      return answer.split("　").shuffle
    when "一問多答"
      return answer.split("　").drop(1).shuffle
    end
  end

  def correct
    case kind
    when "自由記述"
      return answer
    when "一問一答"
      return answer.split("　").first
    when "一問多答"
      answers = answer.split("　")
      id = answers.first.split(",")
      return id.map { |s| answers[s.to_i] }.join("、")
    when "並び替え"
      return answer.split("　").join(" → ")
    end
  end

  def quiz_options
    return answer.split("　").map.with_index { |option, i| [i, option] }.drop(1).to_h.sort_by { rand } if kind == "一問多答"
    return answer.split("　").map.with_index { |option, i| [i, option] }.to_h.sort_by { rand }
  end
end
