class CreateSessions < ActiveRecord::Migration[8.0]
  def up
    create_table :sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :ip_address
      t.string :user_agent
      t.string :source
      t.timestamps
    end
  end

  def down
    drop_table :sessions
  end
end
