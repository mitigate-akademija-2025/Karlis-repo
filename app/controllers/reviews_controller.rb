class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @quiz = Quiz.find(params[:quiz_id])
    @review = @quiz.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      redirect_to quiz_path(@quiz), notice: "Review added succesfully!"
    else
      redirect_to quiz_path(@quiz), alert: "Review could not be added."
    end
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
