require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '', content: '失敗テスト', expired_at: "#{3.day.from_now}")
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: '失敗', content: '', expired_at: "#{3.day.from_now}")
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功', content: '成功', expired_at: "#{3.day.from_now}")
        expect(task).to be_valid
      end
    end
  end

  describe 'タスクモデル機能', type: :model do
    describe '検索機能' do
      # 必要に応じて、テストデータの内容を変更して構わない
      let!(:task) { FactoryBot.create(:task, title: 'task', status: '実行中') }
      let!(:second_task) { FactoryBot.create(:second_task, title: "sample", status: '完了') }
      let!(:third_task) { FactoryBot.create(:third_task, title: "sample", status: '実行中') }
      context 'scopeメソッドでタイトルのあいまい検索をした場合' do
        it "検索キーワードを含むタスクが絞り込まれる" do
          # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
          expect(Task.title_like('task')).to include(task)
          expect(Task.title_like('task')).not_to include(second_task)
          expect(Task.title_like('task').count).to eq 1
        end
      end
      context 'scopeメソッドでステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          expect(Task.status_where('実行中')).to include(task)
          expect(Task.status_where('実行中')).to include(third_task)
          expect(Task.status_where('実行中')).not_to include(second_task)
          expect(Task.status_where('実行中').count).to eq 2
        end
      end
      context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          # ここに内容を記載する
          expect(Task.title_like('task').status_where('実行中')).to include(task)
          expect(Task.title_like('task').status_where('実行中')).not_to include(second_task)
          expect(Task.title_like('task').status_where('実行中')).not_to include(third_task)
          expect(Task.title_like('task').status_where('実行中').count).to eq 1
        end
      end
    end
  end
end
