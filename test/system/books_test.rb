# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    user = create(:user)
    @book = create(:book)
    visit root_path
    fill_in 'Eメール', with: user.email
    fill_in 'パスワード', with: user.password
    click_on 'ログイン'
    assert_text 'ログインしました'
  end

  test 'visiting the index' do
    visit books_url
    assert_selector 'h1', text: '本の一覧'
  end

  test 'visiting the show' do
    visit book_path(@book)
    assert_selector 'h1', text: '本の詳細'
  end

  test 'should create book' do
    visit books_url
    click_on '本の新規作成'
    assert_selector 'h1', text: '本の新規作成'
    fill_in 'タイトル', with: 'ジャバスクリプト本'
    fill_in 'メモ', with: 'JavaScript初心者向けの本'
    fill_in '著者', with: '高橋 一郎'
    attach_file '画像', Rails.root.join('test/fixtures/files/javascript_book.jpeg')
    click_on '登録する'
    assert_text '本が作成されました。'
    assert_text 'ジャバスクリプト本'
    assert_text 'JavaScript初心者向けの本'
    assert_text '高橋 一郎'
    assert_selector "img[src*='javascript_book.jpeg']"
  end

  test 'should update book' do
    visit book_path(@book)
    click_on 'この本を編集'
    assert_selector 'h1', text: '本の編集'
    fill_in 'タイトル', with: 'Reactの教科書'
    fill_in 'メモ', with: 'React初心者向けの本'
    fill_in '著者', with: '鈴木 翔平'
    attach_file '画像', Rails.root.join('test/fixtures/files/react_book.jpg')
    click_on '更新する'
    assert_text '本が更新されました。'
    assert_text 'Reactの教科書'
    assert_text 'React初心者向けの本'
    assert_text '鈴木 翔平'
    assert_selector "img[src*='react_book.jpg']"
  end

  test 'should delete book' do
    visit book_path(@book)
    click_on 'この本を削除'
    assert_text '本が削除されました'
    assert_no_text 'テスト本'
    assert_no_text 'テスト初心者向けの内容です'
    assert_no_text '山田 太郎'
    assert_no_selector "img[src*='ruby_book.jpg']"
  end
end
