require 'rails_helper'

describe 'イベント管理機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  # 詳細表示機能のSpec追加(let!でbeforeの前で必ず呼び出される)
  let!(:oogiri_event_a) { FactoryBot.create(:oogiri_event, title: '最初のイベント', user: user_a) }

  before do
    # ログイン画面にアクセスする
    visit login_path
    # メアドとパスワードを入力する(テキストフィールドに値を入れるにはfill_inメソッドを使う)
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    # 「ログインする」ボタンを押す
    click_button 'ログインする'
  end


  # itの中身をshared_examplesで共通化
  shared_examples_for 'ユーザーAが作成したイベントが表示される' do
    it { expect(page).to have_content '最初のイベント' }
  end


  describe '一覧表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      # 上で定義したshared_examplesを利用する
      it_behaves_like 'ユーザーAが作成したイベントが表示される'
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成したイベントが表示されない' do
        # ユーザーAが作成したイベント名が画面に表示されないことを確認
        # 表示されていないことを期待するときはhave_no_contentというマッチャを使う
        # expect(page).not_to have_content '最初のイベント'と記述しても同じように動作する
        expect(page).to have_no_content '最初のイベント'
      end
    end
  end


  # 詳細表示機能のSpecを追加
  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit oogiri_event_path(oogiri_event_a)
      end

      it_behaves_like 'ユーザーAが作成したイベントが表示される'
    end
  end


  # イベントの新規作成機能のSpec
  describe '新規作成機能' do
    let(:login_user) { user_a }

    before do
      visit new_oogiri_event_path
      fill_in 'イベント名', with: oogiri_event_title
      click_button '登録する'
    end

    context '新規作成画面でタイトルを入力したとき' do
      let(:oogiri_event_title) { '新規作成のテストを書く' }

      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
      end
    end

    context '新規作成画面でタイトルを入力しなかったとき' do
      let(:oogiri_event_title) { '' }

      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content 'イベント名を入力してください'
        end
      end
    end
  end
end
