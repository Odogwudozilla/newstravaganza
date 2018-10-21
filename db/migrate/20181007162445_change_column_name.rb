class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :usersearches, :integer, :count
    rename_column :sources, :identitiy, :identity
  end
end
