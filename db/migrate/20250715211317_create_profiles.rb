class CreateProfiles < ActiveRecord::Migration[8.0]
  def up
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :website
      t.string :phone_number
      t.string :country
      t.string :city
      t.string :about_me
      t.string :username

      t.timestamps
    end
  end

  def down
    drop_table :profiles
  end
end
