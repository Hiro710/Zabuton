class OogiriEvent < ApplicationRecord
  # title属性に値が入っていなければ検証エラー/最大30文字まで
  validates :title, presence: true, length: { maximum: 30 }
  # 自作の検証用メソッドの登録
  validate :validate_title_not_including_comma

  belongs_to :user
  # Active Storageで画像を添付できる様にする
  has_one_attached :image

  # scopeを使ったカスタムのクエリー用メソッドの定義
  scope :recent, -> { order(created_at: :desc) }

  # ransackによる検索機能に利用してよいカラムの範囲を制限する
  # ransackable_attributesは検索対象にすることを許可するカラムを指定。それ以外のカラムは無視される。
  def self.ransackable_attributes(auth_object = nil)
    %w[title created_at]
  end

  # ransackable_associationsは検索条件に絡める関連を指定する。空の配列を返す様にオーバーライドすることで、
  # 検索条件に意図しない関連を除外することができる
  def self.ransackable_associations(auth_object = nil)
    []
  end

  # CSV出力
  def self.csv_attributes
    ["title", "description", "created_at", "updated_at"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |oogiri_event|
        csv << csv_attributes.map{ |attr| oogiri_event.send(attr) }
      end
    end
  end

  # CSV入力
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      oogiri_event = new
      # 以下のsliceはslice("title", "description", "created_at", "updated_at")と同じ意味
      oogiri_event.attributes = row.to_hash.slice(*csv_attributes)
      oogiri_event.save!
    end
  end

  # 自作の検証用メソッドの追加(オブジェクト外部から呼ばれることは想定していない為 private)
  private

  def validate_title_not_including_comma
    errors.add(:title, 'にカンマを含めることはできません') if title&.include?(',')
  end
end
