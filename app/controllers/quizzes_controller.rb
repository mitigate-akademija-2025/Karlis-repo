class QuizzesController < ApplicationController
  before_action :set_quiz, only: %i[ show edit update destroy ]
  before_action :authorize_resource, only: [ :index ]

  def authorize_resource
    authorize Quiz, :index?
  end

  # GET /quizzes or /quizzes.json
  def index
    @quizzes = Quiz.all
  end

  # GET /quizzes/1 or /quizzes/1.json
  def show
      @quiz = Quiz.find(params[:id])
  end

  # GET /quizzes/new
  def new
    @quiz = Quiz.new
    2.times do 
      @quiz.questions.build(name: 'Vai tev ir ko pajautat?')
    end
  end

  # GET /quizzes/1/edit
  def edit
    authorize @quiz
  end

  # POST /quizzes or /quizzes.json
  def create
    @quiz = current_user.quizzes.build(quiz_params)
    if @quiz.save
      redirect_to @quiz, notice: "Quiz created!"
    else
      render :new
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
    authorize @quiz
    @quiz.destroy!
    redirect_to quizzes_path, notice: "Quiz deleted."
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

   def quiz_params
    params.require(:quiz).permit(
      :title,
      :description,
      questions_attributes: [:id, :name, :_destroy]
    )
   end


end
