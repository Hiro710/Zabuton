class OogiriEvent < ApplicationRecord
  # title属性に値が入っていなければ検証エラー/最大30文字まで
  validates :title, presence: true, length: { maximum: 30 }
end
