FactoryBot.define do
  factory :user do
    name { 'user' }
    email { 'aaa@aaa.aaa' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { true }
  end

  factory :second_user, class: User do
    name { 'alice' }
    email { 'bbb@bbb.bbb' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { false }
  end
end
