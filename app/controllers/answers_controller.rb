class AnswersController < ApplicationController
  before_action :set_answer, only: %i[ show edit update destroy ]
  before_action :get_question

  # GET /answers or /answers.json
  def index
    @answers = @question.answer
  end

  # GET /answers/1 or /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = @question.answer.build
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers or /answers.json
  def create
    @answer = @question.answer.build(answer_params)

    respond_to do |format|
      if @answer.save
        format.html { redirect_to question_answers_path(@question), notice: "Answer was successfully created." }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1 or /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to question_answers_path(@question), notice: "Answer was successfully updated." }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1 or /answers/1.json
  def delete
    @answer = Answer.find(params[:id])
  end

    def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to question_answers_path(@question), notice: "Answer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
	def get_question
	  @question = Question.find(params[:question_id])
	end
	
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Question.find(params[:question_id]).answer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def answer_params
      params.require(:answer).permit(:choice, :question)
    end
end
