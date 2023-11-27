class QuestionsController < ApplicationController
  def top
  end

  def game
    questions = Question.order("RANDOM()").limit(5)
    session[:questions_order] = questions.pluck(:id)
    session[:answered_question_count] = 0
  end

  def answer
    user_answer = params[:answer]
    correnct_answer = Question.find_by(params[:id])
    # 1問目
    if session[:answered_question_count] == 0
      question_id = session[:questions_order].shift! unless session[:questions_order].empty?
      @question = Question.find_by(id: question_id)
      session[:answered_question_count] += 1
      # ajaxでページ遷移する
      respond_to do |format|

      end
    # 2問目~5問目
    elsif session[:answered_question_count] > 0 && session[:answered_question_count] < 5
      #正解していたら次の問題へ
      if user_answer == correnct_answer.answer
        question_id = session[:questions_order].shift! unless session[:questions_order].empty?
        @question = Question.find_by(id: question_id)
        session[:answered_question_count] += 1
        # ajaxでページ遷移する
        respond_to do |format|
        
        end
      # ゲームオーバーしたら問題数をリセットしてゲームオーバー画面へリダイレクト
      else
        reset_session
        redirect_to questions_gameover_path
      end
    #5問正解したら問題数をリセットしてゲームクリア画面へリダイレクト
    elsif session[:answered_question_count] == 5
      reset_session
      render questions_clear_path
    end
  end

  def gameover
  end
end
