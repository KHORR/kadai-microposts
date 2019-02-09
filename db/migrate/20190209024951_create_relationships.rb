class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      # t.referencesの記述は別のテーブルを参照させるという意味
      t.references :user, foreign_key: true
      t.references :follow, foreign_key: { to_table: :users }
      
      t.timestamps
      
      # user_idとfollow_idのペアで重複するものが保存されないようにする設定
      t.index [:user_id, :follow_id], unique: true
    end
  end
end
