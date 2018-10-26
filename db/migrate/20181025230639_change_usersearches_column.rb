class ChangeUsersearchesColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :usersearches, :integer
    remove_column :usersearches, :status
    change_column :usersearches, :totalresults, :integer
  end
end
