class OogiriEvent < ApplicationRecord
  # title属性に値が入っていなければ検証エラー/最大30文字まで
  validates :title, presence: true, length: { maximum: 30 }
  # 自作の検証用メソッドの登録
  validate :validate_title_not_including_comma

  belongs_to :user

  # scopeを使ったカスタムのクエリー用メソッドの定義
  scope :recent, -> { order(created_at: :desc) }


  # 自作の検証用メソッドの追加(オブジェクト外部から呼ばれることは想定していない為 private)
  private

  def validate_title_not_including_comma
    errors.add(:title, 'にカンマを含めることはできません') if title&.include?(',')
  end
end
