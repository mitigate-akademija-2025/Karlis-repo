class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @quizzes = @user.quizzes
    @recent_completed_quizzes = []
  end
end