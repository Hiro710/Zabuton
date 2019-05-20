class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false

      t.timestamps
      # 同じメアドを持つユーザが複数人存在しない(一意制約)
      t.index :email, unique: true
    end
  end
end
