require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, title: 'task', status: '実行中', priority: '高', user: user) }
  let!(:user) { FactoryBot.create(:user) }
  let!(:second_user) { FactoryBot.create(:second_user) }
  let!(:second_label)  { FactoryBot.create(:second_label) }
  # describe '新規作成機能' do
  #   context 'タスクを新規作成した場合' do
  #     it '作成したタスクが表示される' do
  #       visit root_path
  #       fill_in 'Email', with: 'aaa@aaa.aaa'
  #       fill_in 'Password', with: 'password'
  #       click_on 'Log in'
  #       visit new_task_path
  #       fill_in "task_title", with: 'mytask'
  #       fill_in "task_content", with: 'mycontent'
  #       click_on '登録する'
  #       expect(page).to have_content 'mytask'
  #     end
  #   end
  # end
  # describe '一覧表示機能' do
  #   before do
  #     FactoryBot.create(:second_task, title: 'task2', priority: '中', user: user)
  #     FactoryBot.create(:third_task, title: 'task3',priority: '低', user: user)
  #     visit root_path
  #     fill_in 'Email', with: 'aaa@aaa.aaa'
  #     fill_in 'Password', with: 'password'
  #     click_on 'Log in'
  #     # 「一覧画面に遷移した場合」や「タスクが作成日時の降順に並んでいる場合」など、contextが実行されるタイミングで、before内のコードが実行される
  #   end
    
  #   context '一覧画面に遷移した場合' do
  #     it '作成済みのタスク一覧が表示される' do
  #       # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
  #       # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
  #       expect(page).to have_content 'task'
  #       # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
  #     end
  #   end
  #   context 'タスクが作成日時の降順に並んでいる場合' do
  #     it '新しいタスクが一番上に表示される' do
  #       task_list = all('.task_row') 
  #       expect(task_list[0]).to have_content 'task3'
  #       expect(task_list[1]).to have_content 'task'
  #       expect(task_list[2]).to have_content 'task2'
  #     end
  #   end
  #   context '終了期限でソートするをクリックした場合' do
  #     it '終了期限が近い順に表示される' do
  #       click_on '終了期限▼'
  #       sleep 1
  #       task_list = all('.task_row') 
  #       expect(task_list[0]).to have_content 'task2'
  #       expect(task_list[1]).to have_content 'task3'
  #       expect(task_list[2]).to have_content 'task'
  #     end
  #   end
  #   context '優先順位でソートするをクリックした場合' do
  #     it '優先度が高い順に表示される' do
  #       click_on '優先度▼'
  #       sleep 1
  #       task_list = all('.task_row') 
  #       expect(task_list[0]).to have_content 'task'
  #       expect(task_list[1]).to have_content 'task2'
  #       expect(task_list[2]).to have_content 'task3'
  #     end
  #   end
  # end

  # describe 'ページ遷移機能' do
  #   before do
  #     14.times { FactoryBot.create(:task, user: user) }
  #     FactoryBot.create(:second_task, title: 'task22', user: user)
  #     visit root_path
  #     fill_in 'Email', with: 'aaa@aaa.aaa'
  #     fill_in 'Password', with: 'password'
  #     click_on 'Log in'
  #   end
  #   context 'taskテーブルのレコードが16個以上ある場合' do
  #     it '２ページ目に遷移する' do
  #       click_on 2
  #       expect(page).to have_content 'task22'
  #     end
  #   end
  # end

  # describe '詳細表示機能' do
  #   context '任意のタスク詳細画面に遷移した場合' do
  #     it '該当タスクの内容が表示される' do
  #       visit root_path
  #       fill_in 'Email', with: 'aaa@aaa.aaa'
  #       fill_in 'Password', with: 'password'
  #       click_on 'Log in'
  #       visit tasks_path
  #       click_on '詳細'
  #       expect(page).to have_content 'task'
  #     end
  #   end
  # end

  # describe '検索機能' do
  #   before do
  #     # 必要に応じて、テストデータの内容を変更して構わない
  #     FactoryBot.create(:second_task, title: "task2", status: "未着手", user: user)
  #     FactoryBot.create(:third_task, title: "task2", status: "実行中", user: user)
  #     visit root_path
  #     fill_in 'Email', with: 'aaa@aaa.aaa'
  #     fill_in 'Password', with: 'password'
  #     click_on 'Log in'
  #   end

  #   context 'タイトルであいまい検索をした場合' do
  #     it "検索キーワードを含むタスクで絞り込まれる" do
  #       visit tasks_path
  #       # タスクの検索欄に検索ワードを入力する (例: task)
  #       fill_in "task_title", with: 'task'
  #       # 検索ボタンを押す
  #       click_on '検索する'
  #       expect(page).to have_content 'task'
  #     end
  #   end
  #   context 'ステータス検索をした場合' do
  #     it "ステータスに完全一致するタスクが絞り込まれる" do
  #       # ここに実装する
  #       # プルダウンを選択する「select」について調べてみること
  #       visit tasks_path
  #       select "未着手", from: 'task[status]'
  #       click_on '検索する'
  #       task_list = all('.task_row').first
  #       expect(task_list).to have_content '未着手'
  #     end
  #   end
  #   context 'タイトルのあいまい検索とステータス検索をした場合' do
  #     it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
  #       visit tasks_path
  #       fill_in "task_title", with: 'task2'
  #       select "実行中", from: 'task[status]'
  #       task_list = all('.task_row').first
  #       expect(task_list).to have_content '実行中'
  #     end
  #   end
  # end
  # describe 'ユーザー登録のテスト' do
  #   context 'ログインせずにタスク一覧画面に飛ぼうとした場合' do
  #     it 'ログイン画面に遷移する' do
  #       visit tasks_path
  #       expect(page).to have_content 'ログインをして下さい'
  #     end
  #   end
  #   context 'ユーザーを新規登録できること' do
  #     it "新規登録を行うと一覧画面に遷移し、登録された名前が表示される" do
  #       visit root_path
  #       click_on '新規登録'
  #       fill_in 'user_name', with: 'alice'
  #       fill_in 'user_email', with: 'test@test.test'
  #       fill_in 'user_password', with: 'password'
  #       fill_in 'user_password_confirmation', with: 'password'
  #       click_on '登録する'
  #       expect(page).to have_content 'aliceさんようこそ'
  #     end
  #   end
  # end
  
  # describe 'セッション機能のテスト' do
  #   context 'ログインができること' do
  #     it 'ログイン情報を入力してログインボタンを押したらタスク一覧画面に遷移する' do
  #       visit root_path
  #       fill_in 'Email', with: 'aaa@aaa.aaa'
  #       fill_in 'Password', with: 'password'
  #       click_on 'Log in'
  #       expect(page).to have_content 'タスク一覧'
  #     end
  #   end
  #   context 'ログインしてマイページをクリックした場合' do
  #     it "自分の詳細画面(マイページ)飛べる" do
  #       visit root_path
  #       fill_in 'Email', with: 'aaa@aaa.aaa'
  #       fill_in 'Password', with: 'password'
  #       click_on 'Log in'
  #       click_on 'マイページ'
  #       expect(page).to have_content 'userさんのページ'
  #     end
  #   end
  #   context '一般ユーザが他人の詳細画面に飛んだ場合' do
  #     it "タスク一覧画面に遷移する" do
  #       visit root_path
  #       fill_in 'Email', with: 'aaa@aaa.aaa'
  #       fill_in 'Password', with: 'password'
  #       click_on 'Log in'
  #       visit  user_path(second_user.id)
  #       expect(page).to have_content 'タスク一覧'
  #     end
  #   end
  #   context 'ログアウトボタンをクリックした場合' do
  #     it "ログアウトできること" do
  #       visit root_path
  #       fill_in 'Email', with: 'aaa@aaa.aaa'
  #       fill_in 'Password', with: 'password'
  #       click_on 'Log in'
  #       click_on 'ログアウト'
  #       expect(page).to have_content 'ログアウトしました'
  #     end
  #   end
  # end
  # describe '管理画面のテスト' do
  #   context '管理ユーザでログインした場合' do
  #     before do
  #       visit root_path
  #       fill_in 'Email', with: 'aaa@aaa.aaa'
  #       fill_in 'Password', with: 'password'
  #       click_on 'Log in'
  #     end
  #       it '管理画面にアクセスできる' do
  #         click_on 'ユーザー一覧'
  #         expect(page).to have_content 'ユーザー管理画面'
  #       end
  #       it 'ユーザの新規登録ができる' do
  #         click_on 'ユーザー一覧'
  #         click_on '新規作成'
  #         fill_in 'user_name', with: 'bob'
  #         fill_in 'user_email', with: 'bob@bob.bob'
  #         fill_in 'user_password', with: 'password'
  #         fill_in 'user_password_confirmation', with: 'password'
  #         check 'Admin'
  #         click_on '登録する'
  #         expect(page).to have_content 'bob'
  #       end
  #       it 'ユーザの詳細画面にアクセスできる' do
  #         click_on 'ユーザー一覧'
  #         user_list = all('.user_row')
  #         user_list[1].click_on 'マイページ'
  #         expect(page).to have_content 'aliceさんのページ'
  #       end
  #       it 'ユーザの編集画面からユーザを編集できる' do
  #         click_on 'ユーザー一覧'
  #         user_list = all('.user_row')
  #         user_list[1].click_on '編集'
  #         fill_in 'user_name', with: 'other_person'
  #         fill_in 'user_password', with: 'password'
  #         fill_in 'user_password_confirmation', with: 'password'
  #         click_on '変更する'
  #         expect(page).to have_content 'other_person'
  #       end
  #       it 'ユーザの削除をできる' do
  #         click_on 'ユーザー一覧'
  #         user_list = all('.user_row')
  #         user_list[1].click_on '削除'
  #         page.driver.browser.switch_to.alert.accept
  #         expect(page).not_to have_content 'alice'
  #       end
  #   end
  # end

  describe 'ラベル機能' do
    before do
      visit root_path
      fill_in 'Email', with: 'aaa@aaa.aaa'
      fill_in 'Password', with: 'password'
      click_on 'Log in'
    end
    # context '任意のタスク詳細画面に遷移した場合' do
    #   it '貼られているラベルの内容が表示される' do
    #     visit tasks_path
    #     click_on '詳細'
    #     expect(page).to have_content 'ラベル１'
    #   end
    # end
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
    end
    #   it 'タスクにラベルを複数貼ることができる' do
    #     visit new_task_path
    #     fill_in "task_title", with: 'task'
    #     fill_in "task_content", with: 'content'
    #     check 'task_label_ids_353'
    #     check 'task_label_ids_354'
    #     click_on '登録する'
    #     task_list = all('.task_row').first
    #     task_list.click_on '詳細'
    #     expect(page).to have_content 'ラベル１'
    #     expect(page).to have_content 'ラベル２'
    #   end
    # end
    # context 'タスクを編集する場合' do
    #   it 'ラベルを変更できる' do
    #     visit tasks_path
    #     click_on '編集'
    #     check 'task_label_ids_355'
    #     click_on '登録する'
    #     click_on '詳細'
    #     expect(page).to have_content 'ラベル２'
    #   end
    # end
  end
  # describe 'ラベル検索機能' do
  #   before do
  #     FactoryBot.create(:second_task, title: 'task2', status: '完了', priority: '高', user: user)
  #     FactoryBot.create(:third_task, title: 'task', status: '実行中', user: user)
  #     visit root_path
  #     fill_in 'Email', with: 'aaa@aaa.aaa'
  #     fill_in 'Password', with: 'password'
  #     click_on 'Log in'
  #   end
  #   context 'ラベルで検索した場合' do
  #     it 'ラベルを含むタスクで絞り込まれる' do
  #       select "ラベル１", from: 'task[label_id]'
  #       click_on '検索する'
  #       task_list = all('.task_row')
  #       task_list.first.click_on '詳細'
  #       expect(page).to have_content 'ラベル１'
  #     end
  #   end
  #   context 'ステータスとラベルで検索した場合' do
  #     it 'ステータスが完全一致するものとラベルを含むタスクで絞り込まれる' do
  #       select "実行中", from: 'task[status]'
  #       select "ラベル１", from: 'task[label_id]'
  #       click_on '検索する'
  #       task_list = all('.task_row').first
  #       task_list.click_on '詳細'
  #       expect(page).to have_content 'ラベル１'
  #       expect(page).to have_content '実行中'
  #     end
  #   end
  #   context 'タイトルとラベルで検索した場合' do
  #     it 'タイトルが部分一致するものとラベルを含むタスクで絞り込まれる' do
  #       fill_in "task_title", with: 'task'
  #       select "ラベル１", from: 'task[label_id]'
  #       click_on '検索する'
  #       task_list = all('.task_row').first
  #       task_list.click_on '詳細'
  #       expect(page).to have_content 'ラベル１'
  #       expect(page).to have_content '実行中'
  #     end
  #   end
  #   context 'タイトルとラベルとステータスで検索した場合' do
  #     it 'タイトルが部分一致かつステータスが完全一致かつラベルを含むタスクで絞り込まれる' do
  #       fill_in "task_title", with: 'task'
  #       select "実行中", from: 'task[status]'
  #       select "ラベル１", from: 'task[label_id]'
  #       click_on '検索する'
  #       task_list = all('.task_row').first
  #       task_list.click_on '詳細'
  #       expect(page).to have_content 'ラベル１'
  #       expect(page).to have_content '実行中'
  #     end
  #   end
  # end
end