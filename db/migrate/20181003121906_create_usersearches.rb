class CreateUsersearches < ActiveRecord::Migration[5.2]
  def change
    create_table :usersearches do |t|
      t.string :status
      t.string :totalresults
      t.string :integer
      t.references :keyword, foreign_key: true

      t.timestamps
    end
  end
end
