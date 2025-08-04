class CreateApplications < ActiveRecord::Migration[7.0]
  def up
    create_table :applications do |t|
      t.references :quest, null: false, foreign_key: true
      t.references :applicant, null: false, foreign_key: { to_table: :users }
      t.references :approver, null: false, foreign_key: { to_table: :users }
      t.string :status

      t.timestamps
    end
  end

  def down
    drop_table :applications
  end
end
