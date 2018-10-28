class ModifySeveralTablesAndAttributes < ActiveRecord::Migration[5.2]
  def change
    remove_column :usersearches, :country_id
    remove_column :usersearches, :language_id
    # remove_column :articles, :country_id
    # remove_column :articles, :language_id
    change_column :usersearches, :totalresults, :string
    rename_column :usersearches, :totalresults, :description
    rename_column :usersearches, :source_id, :news_source_id
    rename_column :articles, :source_id, :news_source_id
    add_reference :news_sources, :language, foreign_key: true
    add_reference :news_sources, :country, foreign_key: true
    add_reference :usersearches, :article, foreign_key: true
  end
end
