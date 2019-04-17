class CreateOogiriEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :oogiri_events do |t|
      t.string :title # , null: falseでもNOT NULL制約がかけられる
      t.text :description

      t.timestamps
    end
  end
end
