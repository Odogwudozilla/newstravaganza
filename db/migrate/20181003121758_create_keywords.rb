class CreateKeywords < ActiveRecord::Migration[5.2]
  def change
    create_table :keywords do |t|
      t.string :keyword
      t.integer :hit_rate

      t.timestamps
    end
  end
end
