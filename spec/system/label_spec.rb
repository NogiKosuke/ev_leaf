require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, title: 'task', status: '実行中', priority: '高', user: user) }
  let!(:user) { FactoryBot.create(:user) }
  let!(:second_user) { FactoryBot.create(:second_user) }
  let!(:second_label)  { FactoryBot.create(:second_label) }
  describe 'ラベル機能' do
    before do
      visit root_path
      fill_in 'Email', with: 'aaa@aaa.aaa'
      fill_in 'Password', with: 'password'
      click_on 'Log in'
    end
    context '任意のタスク詳細画面に遷移した場合' do
      it '貼られているラベルの内容が表示される' do
        visit tasks_path
        click_on '詳細'
        expect(page).to have_content 'ラベル１'
      end
    end
    context 'タスクを新規作成する場合' do
      it 'タスクにラベルを貼ることができる' do
        visit new_task_path
        fill_in "task_title", with: 'task'
        fill_in "task_content", with: 'content'
        check 'ラベル２'
        click_on '登録する'
        task_list = all('.task_row').first
        task_list.click_on '詳細'
        expect(page).to have_content 'ラベル２'
      end
      it 'タスクにラベルを複数貼ることができる' do
        visit new_task_path
        fill_in "task_title", with: 'task'
        fill_in "task_content", with: 'content'
        check 'ラベル１'
        check 'ラベル２'
        click_on '登録する'
        task_list = all('.task_row').first
        task_list.click_on '詳細'
        expect(page).to have_content 'ラベル１'
        expect(page).to have_content 'ラベル２'
      end
    end
    context 'タスクを編集する場合' do
      it 'ラベルを変更できる' do
        visit tasks_path
        click_on '編集'
        check 'ラベル２'
        click_on '登録する'
        click_on '詳細'
        expect(page).to have_content 'ラベル２'
      end
    end
  end
  describe 'ラベル検索機能' do
    before do
      FactoryBot.create(:second_task, title: 'task2', status: '完了', priority: '高', user: user)
      FactoryBot.create(:third_task, title: 'task', status: '実行中', user: user)
      visit root_path
      fill_in 'Email', with: 'aaa@aaa.aaa'
      fill_in 'Password', with: 'password'
      click_on 'Log in'
    end
    context 'ラベルで検索した場合' do
      it 'ラベルを含むタスクで絞り込まれる' do
        select "ラベル１", from: 'task[label_id]'
        click_on '検索する'
        task_list = all('.task_row')
        task_list.first.click_on '詳細'
        expect(page).to have_content 'ラベル１'
      end
    end
    context 'ステータスとラベルで検索した場合' do
      it 'ステータスが完全一致するものとラベルを含むタスクで絞り込まれる' do
        select "実行中", from: 'task[status]'
        select "ラベル１", from: 'task[label_id]'
        click_on '検索する'
        task_list = all('.task_row').first
        task_list.click_on '詳細'
        expect(page).to have_content 'ラベル１'
        expect(page).to have_content '実行中'
      end
    end
    context 'タイトルとラベルで検索した場合' do
      it 'タイトルが部分一致するものとラベルを含むタスクで絞り込まれる' do
        fill_in "task_title", with: 'task'
        select "ラベル１", from: 'task[label_id]'
        click_on '検索する'
        task_list = all('.task_row').first
        task_list.click_on '詳細'
        expect(page).to have_content 'ラベル１'
        expect(page).to have_content '実行中'
      end
    end
    context 'タイトルとラベルとステータスで検索した場合' do
      it 'タイトルが部分一致かつステータスが完全一致かつラベルを含むタスクで絞り込まれる' do
        fill_in "task_title", with: 'task'
        select "実行中", from: 'task[status]'
        select "ラベル１", from: 'task[label_id]'
        click_on '検索する'
        task_list = all('.task_row').first
        task_list.click_on '詳細'
        expect(page).to have_content 'ラベル１'
        expect(page).to have_content '実行中'
      end
    end
  end
end