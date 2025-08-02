class CreateMissions < ActiveRecord::Migration[8.0]
  def up
    create_table :missions do |t|
      t.string :title, limit: 120
      t.text :description, limit: 600
      t.references :owner, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end

  def down
    drop_table :missions
  end
end
