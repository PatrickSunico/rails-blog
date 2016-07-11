class AlterUsers < ActiveRecord::Migration
  def up
    rename_table('users', 'admin_users')

    # create the column name "username" after the column name "email"
    add_column('admin_users', 'username', :string, :limit => 25, :after =>'email')

    #changes the limit to only 100 character in string
    change_column('admin_users', 'email', :string, :limit => 100)
    rename_column('admin_users','password', 'hashed_password')
    puts "Adding index ..."
    # look up username in our admin_users table
    add_index('admin_users','username')
  end

  def down
    remove_index('admin_users','username')
    rename_column('admin_users','hashed_password', 'password')
    change_column('admin_users', 'email', :string, :default => "", :null => false)
    remove_column('admin_users', 'username')
    rename_table('admin_users', 'users')
  end


end
