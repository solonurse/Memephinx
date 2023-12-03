require 'rails_helper'

RSpec.describe "PlayGames", type: :system do
  before do
    # driven_by(:rack_test)
    # driven_by(:selenium_chrome_headless)
    @questions = create_list(:question, 5)
    @questions.each_with_index { |question, index| question.update(id: index + 1) }
  end

  describe 'クイズを開始' do
    it '問題が出題される' do
      visit questions_game_path
      click_button 'いいや!限界だやるねッ!'
      expect(page).to have_content '第1問'
      expect(current_path).to eq questions_answer_path
    end

    it '回答を間違えるとゲームオーバーになる' do
      visit questions_game_path
      click_button 'いいや!限界だやるねッ!'
      fill_in "answer", with: "間違えた回答"
      click_button '回答する'
      expect(page).to have_content "リトライ"
      expect(current_path).to eq questions_gameover_path
    end

    it '空の回答を送信するとゲームオーバーになる' do
      visit questions_game_path
      click_button 'いいや!限界だやるねッ!'
      fill_in "answer", with: ""
      click_button '回答する'
      expect(page).to have_content "リトライ"
      expect(current_path).to eq questions_gameover_path
    end
  end
end
