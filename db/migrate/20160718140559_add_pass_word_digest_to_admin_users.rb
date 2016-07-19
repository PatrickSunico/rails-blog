class AddPassWordDigestToAdminUsers < ActiveRecord::Migration
  def up
    # Adds a column header inside our admin_users table
    remove_column "admin_users", "hashed_password"
    add_column "admin_users", "password_digest", :string
  end

  def down
    add_column "admin_users", "hashed_password"
    remove_column "admin_users", "password_digest", :string
  end
end
