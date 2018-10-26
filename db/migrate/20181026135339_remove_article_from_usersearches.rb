class RemoveArticleFromUsersearches < ActiveRecord::Migration[5.2]
  def change
    remove_column :usersearches, :article_id
  end
end
