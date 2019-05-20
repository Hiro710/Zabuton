class AddUserIdToOogiriEvents < ActiveRecord::Migration[5.2]
  def up
    # DELETE FROM oogiri_events;で今まで作られたイベントが全て削除される
    execute 'DELETE FROM oogiri_events;'
    add_reference :oogiri_events, :user, null: false, index: true
  end

  def down
    remove_reference :oogiri_events, :user, index: true
  end
end
