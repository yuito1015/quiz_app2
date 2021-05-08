class QuizzesController < ApplicationController
  before_action :logged_in_user
  after_action :destroy, only: [:index]

  def index
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
end
