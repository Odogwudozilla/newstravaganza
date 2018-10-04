class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :author
      t.string :title
      t.string :description
      t.string :url
      t.string :url_image
      t.datetime :published_date
      t.text :content
      t.string :language
      t.references :source, foreign_key: true
      t.references :country, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
