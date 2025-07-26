class CreateUserQuests < ActiveRecord::Migration[8.0]
  def up
    create_table :user_quests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :quest, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :user_quests
  end
end
