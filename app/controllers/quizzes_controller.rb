class QuizzesController < ApplicationController
  before_action :set_quiz, only: %i[ show edit update destroy ]

  # GET /quizzes or /quizzes.json
  def index
    if params[:q].present?
      query = params[:q].downcase
      @quizzes = Quiz.where("LOWER(title) LIKE ?", "%#{query}%")
    else
      @quizzes = Quiz.all
    end
  end

  # GET /quizzes/1 or /quizzes/1.json
  def show
      @quiz = Quiz.find(params[:id])
  end

  # GET /quizzes/new
  def new
    @quiz = Quiz.new
  end

  # GET /quizzes/1/edit
  def edit
    authorize @quiz
  end

  # POST /quizzes or /quizzes.json
  def create
    @quiz = current_user.quizzes.build(quiz_params)
    if @quiz.save
      redirect_to @quiz, notice: "Quiz was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /quizzes/1 or /quizzes/1.json
  def update
    authorize @quiz

    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to @quiz, notice: "Quiz was successfully updated." }
        format.json { render :show, status: :ok, location: @quiz }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1 or /quizzes/1.json
  def destroy
    @quiz = Quiz.find(params[:id])
    if @quiz.user == current_user
      @quiz.destroy
      redirect_to quizzes_path, notice: "Quiz was successfully deleted."
    else
      redirect_to quizzes_path, alert: "You are not authorized to delete this quiz."
    end
  end

  def take
    @quiz = Quiz.find(params[:id])
  end

  def submit
    @quiz = Quiz.find(params[:id])
    @user_answers = params[:answers] || {}

    score = 0
    total_possible = 0
    attempt = QuizAttempt.create(user: current_user, quiz: @quiz)

    @results = @quiz.questions.map do |question|
      user_answer = @user_answers[question.id.to_s]
      correct = false

      if question.question_type == "multiple_choice"
        correct = question.answers.find_by(id: user_answer)&.correct?
      elsif question.question_type == "true_false"
        correct = user_answer.present? && question.answers.find_by(text: user_answer.capitalize)&.correct?
      elsif question.question_type == "text"
        correct = question.answers.any? { |a| a.text.strip.downcase == user_answer.to_s.strip.downcase && a.correct? }
      end

      total_possible += question.points || 1
      score += (question.points || 1) if correct

      attempt.user_answers.create(
        question: question,
        answer: user_answer,
        correct: correct
      )

      { question: question, user_answer: user_answer, correct: correct }
    end

    attempt.update(score: score)
    @total_possible = total_possible
    redirect_to quiz_attempt_path(attempt)
  end

  private

    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

  private

  def quiz_params
    params.require(:quiz).permit(
      :title,
      :description,
      questions_attributes: [
        :id,
        :name,
        :question_type,
        :_destroy,
        answers_attributes: [
          :id,
          :text,
          :correct,
          :_destroy
        ]
      ]
    )
  end
end
