# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    user = create(:user)
    user = create(:user, email: 'test@example.com', password: 'Password!', password_confirmation: 'Password!')
    @report = create(:report, user: user)
    visit root_path
    fill_in 'Eメール', with: 'test@example.com'
    fill_in 'パスワード', with: 'Password!'
    click_on 'ログイン'
    assert_text 'ログインしました'
  end

  test 'visiting the index' do
    visit reports_path
    assert_selector 'h1', text: '日報の一覧'
  end

  test 'visiting the show' do
    visit report_path(@report)
    assert_selector 'h1', text: '日報の詳細'
  end

  test 'should create report' do
    visit reports_path
    click_on '日報の新規作成'
    assert_selector 'h1', text: '日報の新規作成'
    fill_in 'タイトル', with: 'FactoryBotへ置き換え'
    fill_in '内容', with: 'fixturesの代わりにFactoryBotを使ってテストデータを作りました'
    click_on '登録する'
    assert_text '日報が作成されました。'
  end

  test 'should update report' do
    visit report_path(@report)
    click_on 'この日報を編集'
    assert_selector 'h1', text: '日報の編集'
    fill_in 'タイトル', with: 'オブジェクト指向へ着手'
    click_on '更新する'
    assert_text '日報が更新されました。'
  end

  test 'should delete report' do
    visit report_path(@report)
    click_on 'この日報を削除'
    assert_text '日報が削除されました。'
  end
end
