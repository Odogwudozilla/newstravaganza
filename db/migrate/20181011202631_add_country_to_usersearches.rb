class AddCountryToUsersearches < ActiveRecord::Migration[5.2]
  def change
    add_reference :usersearches, :country, foreign_key: true
  end
end
