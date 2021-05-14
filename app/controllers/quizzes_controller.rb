class QuizzesController < ApplicationController
  before_action :logged_in_user
  after_action :destroy, only: [:index]

  def index
    checking_answers
  end

  def show
    @post = Post.find(session["quiz_id_#{params[:id]}"])
  end

  def answer
    if params[:index] && params[:answer]
      session["quiz_answer_#{params[:id]}"] = params[:answer].push(params[:index])
    else
      session["quiz_answer_#{params[:id]}"] = params[:answer]
    end
    params[:id] == "10" ? (redirect_to quizzes_url) : (redirect_to quiz_url(params[:id].to_i + 1))
  end

  def new
  end

  def create
    create_quiz
    redirect_to quiz_url(1)
  end

  def destroy
    destroy_quiz
  end

  private

  def create_quiz
    posts_id = Post.pluck(:id).shuffle[0..10]
    for i in 1..10
      session["quiz_id_#{i}"] = posts_id[i]
    end
  end

  def destroy_quiz
    for i in 1..10
      session.delete("quiz_id_#{i}")
      session.delete("quiz_answer_#{i}")
    end
  end

  def checking_answers
    @quizzes = {}
    @count = 0
    for i in 1..10
      post = Post.find(session["quiz_id_#{i}"])
      if !session["quiz_answer_#{i}"]
        @quizzes[i] = { post: post, result: false, answer: "" }
        next
      end

      case post.kind
      when "自由記述"
        @count += 1 if result = (answer = session["quiz_answer_#{i}"]) == post.answer
      when "一問一答"
        @count += 1 if result = (id = session["quiz_answer_#{i}"]) == "0"
        answer = post.answer.split("　")[id.to_i]
      when "一問多答"
        answers = post.answer.split("　")
        @count += 1 if result = (id = session["quiz_answer_#{i}"].sort) == answers.first.split(",")
        answer = id.map { |s| answers[s.to_i] }.join("、")
      when "並び替え"
        answers = session["quiz_answer_#{i}"].last.reject(&:empty?).map
          .with_index { |s, index| [s, session["quiz_answer_#{i}"][index]] }.to_h.sort.to_h.values
        @count += 1 if result = answers == post.answer.split("　")
        answer = answers.join(" → ")
      end
      @quizzes[i] = { post: post, result: result, answer: answer }
    end
  end
end
