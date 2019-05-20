FactoryBot.define do
  factory :oogiri_event do
    title { 'テストを書く' }
    description { 'RSpec & Capybara & FactoryBotを準備する' }
    # 以下はassociation :user, factory: :admin_userと同じ
    user
  end
end
