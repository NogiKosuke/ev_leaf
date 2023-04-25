require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, title: 'task', status: '実行中', priority: '高') }
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        # 1. new_task_pathに遷移する（新規作成ページに遷移する）
        # ここにnew_task_pathにvisitする処理を書く
        visit new_task_path
        # 2. 新規登録内容を入力する
        #「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄にタスクのタイトルと内容をそれぞれ入力する
        # ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in "task_title", with: 'mytask'
        # ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in "task_content", with: 'mycontent'
        # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
        # ここに「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
        click_on '登録する'
        # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
        # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
        # ここにタスク詳細ページに、テストコードで作成したデータがタスク詳細画面にhave_contentされているか（含まれているか）を確認（期待）するコードを書く
        expect(page).to have_content 'mytask'
      end
    end
  end

  describe '一覧表示機能' do
    before do
      FactoryBot.create(:second_task, title: 'task2', priority: '中')
      FactoryBot.create(:third_task, title: 'task3',priority: '低')
      # 「一覧画面に遷移した場合」や「タスクが作成日時の降順に並んでいる場合」など、contextが実行されるタイミングで、before内のコードが実行される
      visit tasks_path
    end
    
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row') 
        expect(task_list[0]).to have_content 'task3'
        expect(task_list[1]).to have_content 'task'
        expect(task_list[2]).to have_content 'task2'
      end
    end
    context '終了期限でソートするをクリックした場合' do
      it '終了期限が一番遠いものが近い順に表示される' do
        click_on '終了期限▼'
        sleep 1
        task_list = all('.task_row') 
        expect(task_list[0]).to have_content 'task2'
        expect(task_list[1]).to have_content 'task3'
        expect(task_list[2]).to have_content 'task'
      end
    end
    context '優先順位でソートするをクリックした場合' do
      it '終了期限が一番遠いものが近い順に表示される' do
        click_on '優先度▼'
        sleep 1
        task_list = all('.task_row') 
        expect(task_list[0]).to have_content 'task'
        expect(task_list[1]).to have_content 'task2'
        expect(task_list[2]).to have_content 'task3'
      end
    end
  end

  describe 'ページ遷移機能' do
    before do
      14.times { FactoryBot.create(:task) }
      FactoryBot.create(:second_task, title: 'task22')
      visit tasks_path
    end
    context 'taskテーブルのレコードが16個以上ある場合' do
      it '２ページ目に遷移する' do
        click_on 2
        expect(page).to have_content 'task22'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit tasks_path
        click_on '詳細'
        expect(page).to have_content 'task'
      end
    end
  end

  describe '検索機能' do
    before do
      # 必要に応じて、テストデータの内容を変更して構わない
      FactoryBot.create(:second_task, title: "task2", status: "未着手")
      FactoryBot.create(:third_task, title: "task2", status: "実行中")
    end

    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        # タスクの検索欄に検索ワードを入力する (例: task)
        fill_in "task_title", with: 'task'
        # 検索ボタンを押す
        click_on '検索する'
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに実装する
        # プルダウンを選択する「select」について調べてみること
        visit tasks_path
        select "未着手", from: 'task[status]'
        click_on '検索する'
        task_list = all('.task_row').first
        expect(task_list).to have_content '未着手'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in "task_title", with: 'task2'
        select "実行中", from: 'task[status]'
        task_list = all('.task_row').first
        expect(task_list).to have_content '実行中'
      end
    end
  end
end