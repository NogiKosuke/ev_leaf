FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    title { 'test_title' }
    content { 'test_content' }
    created_at{ Time.zone.now }
    expired_at{ 3.day.from_now }
  end

  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
    created_at{ 1.day.ago }
    expired_at{ 1.day.from_now }
  end

  factory :third_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル３' }
    content { 'Factoryで作ったデフォルトのコンテント３' }
    created_at{ 1.day.from_now }
    expired_at{ 2.day.from_now }
  end
end