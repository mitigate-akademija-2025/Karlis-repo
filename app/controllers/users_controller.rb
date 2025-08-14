class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @quizzes_created = current_user.quizzes
    @recent_attempts = current_user.quiz_attempts.order(created_at: :desc).limit(5).includes(:quiz)
  end

  def show
    @user = User.find(params[:id])
    @quizzes = @user.quizzes
    @recent_completed_quizzes = []
  end
end