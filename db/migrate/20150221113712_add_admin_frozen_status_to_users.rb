class AddAdminFrozenStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :banned, :boolean
  end
end