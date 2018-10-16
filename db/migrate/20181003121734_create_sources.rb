class CreateSources < ActiveRecord::Migration[5.2]
  def change
    create_table :sources do |t|
      t.string :identitiy
      t.string :name
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
