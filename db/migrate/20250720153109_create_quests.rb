class CreateQuests < ActiveRecord::Migration[8.0]
  def up
    create_table :quests do |t|
      t.string :title, limit: 55
      t.text :description, limit: 600
      t.references :mission, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :quests
  end
end
