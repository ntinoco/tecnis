class AddPasswordResetFields < ActiveRecord::Migration
  def up
    add_column :users, :password_reset_token, :string
    add_column :users, :password_expires_after, :datetime
  end

  def down
    remove_column :users, :password_reset_token
    remove_column :users, :password_expires_after
  end
end
