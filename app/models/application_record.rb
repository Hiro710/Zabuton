class ApplicationRecord < ActiveRecord::Base
=begin
  全てのActiveRecordモデルに共通の処理を与えるのではなく、特定のカテゴリのActiveRecordモデル群にだけ共通
  の処理を追加する場合、特定のテーブルに紐づかない抽象的なクラスを作って、任意のモデルクラス群に継承する
  ことで実現できる。
  抽象的なクラスを作るには、abstract_class = true を指定する。
  なお、この指定が無いとSTI(Single Table Inheritance：単一テーブル継承)と解釈されてしまう。
=end
  self.abstract_class = true
end
