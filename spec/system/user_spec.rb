require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, title: 'task', status: '実行中', priority: '高', user: user) }
  let!(:user) { FactoryBot.create(:user) }
  let!(:second_user) { FactoryBot.create(:second_user) }
  let!(:second_label)  { FactoryBot.create(:second_label) }
  describe 'ユーザー登録のテスト' do
    context 'ログインせずにタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_content 'ログインをして下さい'
      end
    end
    context 'ユーザーを新規登録できること' do
      it "新規登録を行うと一覧画面に遷移し、登録された名前が表示される" do
        visit root_path
        click_on '新規登録'
        fill_in 'user_name', with: 'alice'
        fill_in 'user_email', with: 'test@test.test'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on '登録する'
        expect(page).to have_content 'aliceさんようこそ'
      end
    end
  end

  describe 'セッション機能のテスト' do
    context 'ログインができること' do
      it 'ログイン情報を入力してログインボタンを押したらタスク一覧画面に遷移する' do
        visit root_path
        fill_in 'Email', with: 'aaa@aaa.aaa'
        fill_in 'Password', with: 'password'
        click_on 'Log in'
        expect(page).to have_content 'タスク一覧'
      end
    end
    context 'ログインしてマイページをクリックした場合' do
      it "自分の詳細画面(マイページ)飛べる" do
        visit root_path
        fill_in 'Email', with: 'aaa@aaa.aaa'
        fill_in 'Password', with: 'password'
        click_on 'Log in'
        click_on 'マイページ'
        expect(page).to have_content 'userさんのページ'
      end
    end
    context '一般ユーザが他人の詳細画面に飛んだ場合' do
      it "タスク一覧画面に遷移する" do
        visit root_path
        fill_in 'Email', with: 'aaa@aaa.aaa'
        fill_in 'Password', with: 'password'
        click_on 'Log in'
        visit  user_path(second_user.id)
        expect(page).to have_content 'タスク一覧'
      end
    end
    context 'ログアウトボタンをクリックした場合' do
      it "ログアウトできること" do
        visit root_path
        fill_in 'Email', with: 'aaa@aaa.aaa'
        fill_in 'Password', with: 'password'
        click_on 'Log in'
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  
  describe '管理画面のテスト' do
    context '管理ユーザでログインした場合' do
      before do
        visit root_path
        fill_in 'Email', with: 'aaa@aaa.aaa'
        fill_in 'Password', with: 'password'
        click_on 'Log in'
      end
        it '管理画面にアクセスできる' do
          click_on 'ユーザー一覧'
          expect(page).to have_content 'ユーザー管理画面'
        end
        it 'ユーザの新規登録ができる' do
          click_on 'ユーザー一覧'
          click_on '新規作成'
          fill_in 'user_name', with: 'bob'
          fill_in 'user_email', with: 'bob@bob.bob'
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'password'
          check 'Admin'
          click_on '登録する'
          expect(page).to have_content 'bob'
        end
        it 'ユーザの詳細画面にアクセスできる' do
          click_on 'ユーザー一覧'
          user_list = all('.user_row')
          user_list[1].click_on 'マイページ'
          expect(page).to have_content 'aliceさんのページ'
        end
        it 'ユーザの編集画面からユーザを編集できる' do
          click_on 'ユーザー一覧'
          user_list = all('.user_row')
          user_list[1].click_on '編集'
          fill_in 'user_name', with: 'other_person'
          fill_in 'user_password', with: 'password'
          fill_in 'user_password_confirmation', with: 'password'
          click_on '変更する'
          expect(page).to have_content 'other_person'
        end
        it 'ユーザの削除をできる' do
          click_on 'ユーザー一覧'
          user_list = all('.user_row')
          user_list[1].click_on '削除'
          page.driver.browser.switch_to.alert.accept
          expect(page).not_to have_content 'alice'
        end
    end
  end
end