class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :sources, :identitiy, :identity
  end
end
