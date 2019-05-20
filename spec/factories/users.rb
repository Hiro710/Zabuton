FactoryBot.define do
  # 以下はfactory :admin_user, class: User doと同じ
  factory :user do
    name { 'テストユーザー' }
    email { 'test1@example.com' }
    password { 'password' }
  end
end
