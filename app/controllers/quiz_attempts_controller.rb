class QuizAttemptsController < ApplicationController
  def show
    @attempt = QuizAttempt.find(params[:id])
    @quiz = @attempt.quiz
    @user_answers = @attempt.user_answers.includes(:question)
  end
end