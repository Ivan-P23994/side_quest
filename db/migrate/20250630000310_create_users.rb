class CreateUsers < ActiveRecord::Migration[8.0]
  def up
    create_table :users do |t|
      t.string :email_address, null: false
      t.string :password_digest, null: false
      t.boolean :active, default: true
      t.string :user_type, null: false

      t.timestamps
    end
    add_index :users, :email_address, unique: true

    execute <<-SQL
      ALTER TABLE users
      ADD CONSTRAINT user_type_check
      CHECK (user_type IN ('business', 'volunteer', 'organization'));
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE users
      DROP CONSTRAINT user_type_check;
    SQL

    drop_table :users
  end
end
