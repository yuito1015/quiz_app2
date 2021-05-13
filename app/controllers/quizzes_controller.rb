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
    session["quiz_answer_#{params[:id]}"] = params[:answer]
    params[:id] == "10" ? (redirect_to quizzes_url) : (redirect_to quiz_url(params[:id].to_i + 1))
  end

  def new
  end

  def create
    create_quiz
    redirect_to quiz_url(1)
  end

  def destroy
  end

  private

  def create_quiz
    posts_id = Post.pluck(:id).shuffle[0..9]
    for i in 1..10
      session["quiz_id_#{i}"] = posts_id[i - 1]
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
      case post.kind
      when "自由記述"
        if result = (answer = session["quiz_answer_#{i}"]) == post.answer
          @count += 1
        end
      when "一問一答"
        if result = (id = session["quiz_answer_#{i}"]) == "0"
          @count += 1
        end
        answer = post.answer.split("　")[id.to_i]
      when "一問多答"
      when "並び替え"
      end
      @quizzes[i] = { post: post, result: result, answer: answer }
    end
  end
end
