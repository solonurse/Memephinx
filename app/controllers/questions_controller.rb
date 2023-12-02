class QuestionsController < ApplicationController
  before_action :count_reset, only: [:top, :game, :gameover, :clear]
  before_action :asked_question, only: [:game]

  def top; end

  def game; end
  
  def answer
    questions_number = Question.all.pluck(:id)
    @question_count = params[:answered_question].to_i

    case @question_count
    when 0
      process_first_answer
    else
      process_second_to_fifth_answer(questions_number)
    end
  end
  
  def gameover; end
  
  def clear; end

  private
    def count_reset
      @question_count = 0
    end

    def asked_question
      session[:asked_question] = []
    end

    def process_first_answer
      @question_count += 1
      @question = Question.find(Random.rand(1..Question.count))
      session[:asked_question] << @question.id
    end

    def process_second_to_fifth_answer(questions_number)
      user_answer = params[:answer]
      correct_answer = Question.find(params[:question_id].to_i)

      if user_answer == correct_answer.answer
        @question_count += 1
        not_answered = questions_number - session[:asked_question]
        @question = Question.find(not_answered.sample)
        session[:asked_question] << @question.id
      else
        redirect_to questions_gameover_path
      end
    end
end
