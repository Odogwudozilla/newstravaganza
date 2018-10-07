class DropArticlesTable < ActiveRecord::Migration[5.2]
  def up
    drop_table :articles
    drop_table :sources

  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
