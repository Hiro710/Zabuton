class ChangeOogiriEventsTitleNotNull < ActiveRecord::Migration[5.2]
  def change
    # イベントのタイトルをNOT NULL制約する
    change_column_null :oogiri_events, :title, false
  end
end
